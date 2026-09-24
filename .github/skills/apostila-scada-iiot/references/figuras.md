# Figuras, diagramas e imagens

As imagens dos PDFs são ativos didáticos reutilizáveis: nunca descartar só por serem antigas.
O que decide é a validade técnica e a legibilidade.

## Pipeline

### 1. Inventariar

```bash
pdfimages -list docs/Livro_SCADA_Versão_para_análise.pdf          # nº, tipo, ppi, tamanho
pdfimages -list -f 30 -l 45 docs/Livro_SCADA_Versão_para_análise.pdf
```

Uma imagem "grande" com `ppi` alto é figura; `smask`/`image` minúsculos são ruído de fundo.

### 2. Extrair

```bash
mkdir -p figuras
# figura embutida, preservando o formato de origem
pdfimages -png -f 42 -l 42 docs/Livro_SCADA_Versão_para_análise.pdf figuras/tmp
# página inteira (quando a figura é vetorial ou composta com texto)
pdftoppm -r 200 -f 42 -l 42 -png docs/Livro_SCADA_Versão_para_análise.pdf figuras/cap04-p42
```

Recorte de uma região (sem passar por editor gráfico):

```bash
pdftoppm -r 300 -f 42 -l 42 -png -x 120 -y 300 -W 900 -H 500 \
  docs/Livro_SCADA_Versão_para_análise.pdf figuras/cap04-fig1-1
```

`pdftoppm` gera sufixo de 3 dígitos (`...-042.png`) — renomear para o padrão da apostila.

### 3. Classificar (4 baldes)

| Classe | Critério | Ação |
|---|---|---|
| Reutilizar diretamente | correta, legível, sem marca obsoleta | incluir como está |
| Reutilizar após tratamento | conteúdo válido, mas com fundo sujo, borda, recorte ruim | recortar/limpar/recomprimir |
| Redesenhar | diagrama conceitual, tipicamente vetorial e datado | recriar em Mermaid |
| Substituir por nova figura | tecnologia mudou (ex.: tela de SCADA geração 2) | nova figura com fonte |

### 4. Nomenclatura

```text
figuras/cap04-fig1-1.png      # figura do capítulo 4, seção 1, primeira
figuras/cap07-m1.mmd          # fonte Mermaid
figuras/cap07-m1.pdf          # Mermaid renderizado (usado no LaTeX)
```

`extrair-fontes.sh` e `render-mermaid.sh` dependem desse padrão — manter.

### 5. Incluir no Markdown

Com imagem real — a legenda **carrega o número** e é ela que o LaTeX imprime
(`\captionsetup[figure]{labelformat=empty}` desliga o rótulo automático, porque a apostila
numera figuras à mão, placeholders incluídos):

```markdown
![Figura 4.1 – Arquitetura básica de um sistema SCADA](../figuras/cap04-arquitetura-basica.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 22 (figura de A. Santos, reproduzida com crédito).
```

O caminho é relativo a `apostila/`. A numeração manual precisa ser **sequencial na ordem de
aparição**, contando figuras reais e placeholders juntos — o `verificar-estrutura.py` cobra isso.

**O que o PDF faz com esse par (e o Markdown/HTML não):** o `callouts.lua` detecta a figura seguida
da caixa `> **Fonte:**` e funde as duas numa legenda só —
`\caption[Figura N.M – Título]{Figura N.M – Título. \textbf{Fonte:} …}`. Motivo: a caixa "Fonte"
é um `tcolorbox` que não flutua, e a figura ia para o topo da página seguinte deixando a fonte
sozinha na anterior (medido: 12 das 20 figuras). Escrever a fonte como bloco `> **Fonte:**`
continua sendo o padrão do repositório; só o PDF a exibe dentro da legenda.

Sem imagem disponível ainda (placeholder com direção de arte, como nos capítulos atuais):

```markdown
> 🖼️ **[Figura 4.2 – Barramento de comunicação redundante]**
> *Diagrama com dois servidores SCADA, dois switches e um CLP, mostrando o caminho ativo e o
> de espera. Destacar a redundância em cor diferente. Fundo branco, sem logomarca de fabricante.*
```

Placeholder não é entrega final: registrar em `status.md` quais figuras ainda faltam substituir.

## Mermaid

```bash
.github/skills/apostila-scada-iiot/scripts/render-mermaid.sh
mmdc -i figuras/cap07-m1.mmd -o figuras/cap07-m1.pdf \
     --puppeteerConfigFile /tmp/puppeteer.json --pdfFit
```

`/tmp/puppeteer.json` → `{"executablePath":"/usr/bin/google-chrome"}` (o Chromium do Puppeteer
não está instalado neste sistema; o Chrome do sistema está).

Regras de legibilidade (verificadas):

- Sem `--pdfFit` o PDF sai em página Carta com o diagrama minúsculo no centro.
- O `mmdc` limita a largura da página a 600 pt: diagrama mais largo é reduzido e a fonte encolhe
  junto. Como a figura entra com `width=\linewidth`, acima de ~3,5:1 o texto fica ruim e acima
  de ~6:1 fica ilegível. Medir com `pdfinfo figuras/cap07-m1.pdf` (Page size).
- Diagrama muito vertical (altura/largura ≳ 1,5) estoura a página: reduzir `width`.
- Para estreitar: `flowchart TB` + cadeia vertical (`A --> B --> C`). `direction TB` dentro de
  subgrafo **só empilha se os nós tiverem arestas** — usar vínculo invisível `~~~` entre nós
  soltos e entre subgrafos.
- **Fan-out largo é o que estoura**, não o número de nós: `flowchart` com um nó que abre três
  colunas (ex.: evento → três proveniências → script) sai 4,1:1 mesmo em `TB`, porque o layout
  posiciona os ramos lado a lado. Confirmado na apostila (cap. 14, diagrama de eventos): a correção
  foi trocar o desenho por uma **cadeia vertical de decisão** (pergunta → sim/não → resultado),
  que deu 0,85:1. Se o diagrama largo for indispensável, reduza o número de folhas por nível.
- `stateDiagram-v2` funciona no pipeline (validado no cap. 14): use ids de estado em ASCII
  (`Parado`, `Partindo`) e o rótulo acentuado depois dos dois-pontos da transição.
- Conferir o resultado visualmente (`pdftoppm -png` + olhar a imagem): o gerador não avisa
  quando a fonte fica ilegível.

### Erros de parse (diagnóstico do `render-mermaid.sh`)

O script avisa quando um `.mmd` falha, mas a mensagem do `mmdc` é uma pilha de `Parser.parseError`
inútil. Reproduza com o arquivo isolado:

```bash
mmdc -i figuras/capitulo-05-m3.mmd -o /tmp/t.pdf \
     --puppeteerConfigFile "${TMPDIR:-/tmp}/puppeteer-apostila.json" --pdfFit
```

Causas confirmadas na apostila atual (as duas que quebraram):

| Sintoma | Causa | Correção |
|---|---|---|
| Falha no parse | **parênteses em rótulo de nó de flowchart** — `B[MQTT Broker (Mosquitto)]` | aspirar o rótulo: `B["MQTT Broker (Mosquitto)"]` |
| Falha no parse | **id de participante igual a palavra reservada**, sem distinção de caixa — `participant OPT as Otimizador` (o `opt` de `opt ... end` é lido como bloco) | renomear o id (`OTIM`, `PARTIC`) |

Reservadas que aparecem com frequência como id: `opt`, `loop`, `alt`, `else`, `end`, `par`,
`note`, `rect`, `critical`, `break`, `box`, `activate`, `autonumber`, `as`, `and`.
O alias depois de `as` **aceita** parênteses e acentos (`participant CLP as CLP (Campo)` é válido);
o que não se pode é pôr o alias entre aspas.

Diagnóstico rápido quando um diagrama falha: reduza ao mínimo (uma linha) e acrescente partes até
quebrar. Falhas de parse não têm relação com o tamanho/proporção — são gramática.

## Reuso direto de página do PDF (alternativa à extração)

```latex
\includegraphics[page=42,width=\linewidth,trim=0 0 0 0,clip]{../docs/Livro_SCADA.pdf}
```

Cuidado: pesa no PDF final e mantém o estilo gráfico antigo. Só para figuras que não se
consegue reproduzir nem redesenhar.

## Fontes e direitos

- Toda figura precisa de `Fonte:` — do material original, redesenhada, elaboração própria ou
  norma/referência.
- Imagem da internet: apenas licença compatível (CC, domínio público, uso permitido) e sempre
  com atribuição e link.
- Proibido: propaganda de fabricante, captura com logomarca de terceiros, figura sem origem.
- Captura de tela de software comercial: usar quando o objetivo é mostrar a interface
  (ex.: tela de SCADA), citando fabricante e versão, sem caráter promocional.
