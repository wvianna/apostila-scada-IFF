---
name: apostila-scada-iiot
description: >-
  Refatora, atualiza, expande e compila a apostila de Sistemas de Supervisão Industrial /
  SCADA / HMI / IoT / IIoT deste workspace: converte os PDFs de origem para Markdown,
  extrai e reaproveita as figuras dos PDFs, redige/reescreve capítulos, aplica normas
  (ISA-18.2, IEC 62682, EEMUA 191, NAMUR NA 102, IEC 62443) e gera o PDF final em LaTeX
  (capa, sumário, capítulos, figuras, tabelas, referências, anexos). Use quando o pedido for
  "crie a apostila", "refatore o capítulo N", "atualize o capítulo N", "converta os PDFs",
  "extraia as imagens/figuras", "crie o capítulo sobre alarmes / ThingsBoard / Node-RED /
  dashboards / Grafana / OPC UA / MQTT / Edge / Cloud", "crie um exemplo com Node-RED ou
  ThingsBoard", "faça um estudo de caso", "compile o PDF da apostila".
argument-hint: 'ex.: refatore o capítulo 3 | crie o capítulo de alarmes | extraia as figuras | compile o PDF'
---

# Apostila — Supervisão Industrial, SCADA, IoT e IIoT

Skill editorial e técnica para **reconstruir, refatorar, atualizar e expandir** a apostila deste
workspace, a partir dos PDFs de origem, preservando o que é válido e modernizando o que ficou
obsoleto. Cada afirmação técnica precisa de origem rastreável; figura sem fonte não entra.

## O que a skill produz

- Capítulos em Markdown em `apostila/` (fonte de verdade), no padrão didático fixado em
  [estrutura.md](./references/estrutura.md).
- Texto convertido dos PDFs e inventário de figuras em `docs/fontes/`.
- Figuras extraídas/redesenhadas em `figuras/` (PNG dos PDFs, PDF vetorial dos Mermaid).
- PDF final em `latex/apostila.pdf`, gerado por [scripts/build-pdf.sh](./scripts/build-pdf.sh).
- `README.md`, `handoff.md` e `status.md` na raiz, atualizados a cada rodada.

## Mapa do workspace (verificado)

| Caminho | Papel | Regra |
|---|---|---|
| `promptSkill.md` | especificação editorial (30 seções) | requisito, não fonte técnica |
| `docs/*.pdf` (11 arquivos, ~498 p.) | **fontes originais** | nunca editar nem mover |
| `docs/fontes/` | texto convertido + `_imagens.csv` | gerado; conferir contra o PDF |
| `apostila/*.md` | **fonte de verdade** dos capítulos | editar aqui |
| `docs/apostila/` | `rebuild.py` + HTML gerado | **não** guarda cópias dos capítulos: o script lê de `apostila/` |
| `figuras/` | figuras e `.mmd` | nome `capNN-figX-Y.*` |
| `latex/` | gerado (`.tex`, `build/`) | descartável, não versionar conteúdo |
| `docs/apostila/rebuild.py` | pipeline HTML | funcional: lê `apostila/*.md` e regenera `docs/apostila/apostila-scada.html` (CSS/JS preservados do próprio HTML) |
| `LICENSE.md` | CC BY-SA 4.0 | manter |

Corpus de origem: `Livro_SCADA_Versão_para_análise.pdf` (144 p.), `supervisorio_scada.pdf`
(67 p.), `ISA101.pdf` (64 p.), `ISA-101-III-Simpósio-...-Sabesp-Nov2016.pdf` (68 p.),
`ISA_boas-praticas_SCADAPIMS-2017.pdf` (42 p.), `IoT.pdf` (34 p.),
`Node-Red_InterfaceDeSupervisão.pdf` (21 p.), `IIoT e suas Tecnologias Aderentes.pdf` (18 p.),
`Sistemas Supervisórios ... parte 1/2.pdf` (16 p. cada),
`lopez_research_an_introduction_to_iot_..._portuguese.pdf` (8 p.).
Detalhe por assunto e o mapeamento capítulo↔fonte estão em [fontes.md](./references/fontes.md).

## Fluxo de trabalho

### 0. Rotear o pedido

| Pedido | Ação |
|---|---|
| "crie a apostila" | inventário completo (fases 1–6), nunca escrever antes de analisar |
| "refatore/atualize o capítulo N" | localizar fonte + figuras + referências do capítulo **antes** de reescrever |
| "converta os PDFs" | [scripts/extrair-fontes.sh](./scripts/extrair-fontes.sh) |
| "extraia as imagens" | `pdfimages` + catalogação, ver [figuras.md](./references/figuras.md) |
| "crie o capítulo de alarmes" | [alarmes.md](./references/alarmes.md) (verificar edição/escopo das normas) |
| "crie exemplo/estudo de caso" | estrutura de cenário em `estrutura.md` §Exemplos |
| "compile o PDF" | [scripts/build-pdf.sh](./scripts/build-pdf.sh) |

### 1. Inventário e proveniência

Listar fontes, medir o capítulo atual e registrar **de onde vem cada trecho**:
herdado · refatorado · atualizado · novo · norma · pesquisa externa. Regra completa em
[fontes.md](./references/fontes.md). Sem origem conhecida, o trecho não é escrito.

### 2. Extração (texto + imagens)

```bash
.github/skills/apostila-scada-iiot/scripts/extrair-fontes.sh
```

Gera `docs/fontes/<slug>.md` e `docs/fontes/_imagens.csv`.
**Armadilha:** tabelas saem colapsadas/fundidas na conversão — nunca copiar tabela do Markdown
convertido; reescrever a partir da página do PDF (`pdftotext -layout -f P -l P`).
Páginas sem texto útil (figura vetorial) exigem OCR: ver `fontes.md`.

### 3. Refatoração e redação

Seguir o esqueleto de capítulo e os mínimos visuais de [estrutura.md](./references/estrutura.md).
Editar sempre `apostila/`, depois propagar para a cópia e registrar o capítulo novo no sumário
(`apostila/indice.md`) e na lista `FILES` de `docs/apostila/rebuild.py`.

### 4. Atualização tecnológica

Conceito antigo → perguntar se continua válido. Válido: preservar e trocar os exemplos.
Inválido: explicar a evolução e apresentar a tecnologia atual, com a caixa de destaque:

```markdown
> 📌 **Atualização tecnológica:** o conceito apresentado originalmente foi complementado/
> atualizado para refletir tecnologias atualmente utilizadas na indústria.
```

Nunca substituir um conceito por outro em silêncio.

### 5. Figuras e diagramas

Extrair/redesenhar e renderizar Mermaid:

```bash
.github/skills/apostila-scada-iiot/scripts/render-mermaid.sh
```

Classificar cada figura em: reutilizar · reutilizar após tratamento · redesenhar · substituir.
Diagrama conceitual simples → Mermaid (`flowchart`) em vez de imagem rasterizada.
Toda figura leva `Fonte:`. Regras, comandos e limites de proporção em
[figuras.md](./references/figuras.md).

### 6. Compilação e verificação

```bash
.github/skills/apostila-scada-iiot/scripts/build-pdf.sh      # MD -> LaTeX -> PDF
.github/skills/apostila-scada-iiot/scripts/verificar-estrutura.py   # gate editorial
```

O build reporta erros reais, `Overfull \vbox` e figuras ausentes. Armadilhas de LaTeX
(sem `latexmk`, sem `siunitx`, `\tabcolsep`, `tcolorbox`, `lstlisting`) em
[latex.md](./references/latex.md) — **ler antes de mexer no template**.

## Regras invioláveis

1. Idioma **pt-BR**; sigla definida na primeira ocorrência: `SCADA (*Supervisory Control and
   Data Acquisition*)`.
2. Não inventar conteúdo, página, figura ou citação. Sem base sólida, não escrever.
3. Toda tabela/figura convertida é **conferida na página original** antes de entrar no texto.
4. Não copiar literalmente os PDFs: refatorar. Norma é resumida em princípios, nunca reproduzida.
5. Sem propaganda de fabricante; produtos citados por função e característica, não por ranking.
6. Não apresentar IoT/IIoT como substituto automático de SCADA — explicar arquiteturas híbridas.
7. Norma citada: verificar **título, edição, status e escopo** (ver
   [normas-ciberseguranca.md](./references/normas-ciberseguranca.md)). Alarmes de processo =
   ISA-18.2 / IEC 62682 / EEMUA 191 / NAMUR NA 102 — **não** atribuir esses requisitos a
   IEC 60839 ou a normas de alarme de segurança patrimonial.
8. Referência desatualizada → mostrar "Referência histórica", "Referência atualmente aplicável",
   "Motivo da atualização".
9. Imagem externa: só com licença compatível (CC/domínio público) e fonte citada.
10. `docs/` é imutável; `apostila/` é a fonte de verdade; `latex/` é descartável.

## Gate de qualidade

Antes de declarar um capítulo concluído (checklist completa em `estrutura.md` §23):

- [ ] 3+ figuras, 2+ diagramas (Mermaid), 1 tabela comparativa, 1 estudo de caso, 2 quadros de
      destaque, 5–10 questões de revisão, seção de referências.
- [ ] Fontes conferidas no PDF; nenhuma tabela copiada da conversão.
- [ ] Figuras com `Fonte:`; placeholders restantes justificados.
- [ ] `verificar-estrutura.py` sem avisos novos; build sem erro e sem `Overfull \vbox`.
- [ ] Sumário, `rebuild.py` e cópia `docs/apostila/` atualizados.
- [ ] `status.md` e `handoff.md` refletindo o estado real.

## Referências

- [estrutura.md](./references/estrutura.md) — arquitetura de 22 capítulos, lacunas vs. atual,
  esqueleto de capítulo, convenções, exemplos, questões, checklist de QC.
- [fontes.md](./references/fontes.md) — inventário do corpus, conversão, OCR, rastreabilidade.
- [figuras.md](./references/figuras.md) — extração, classificação, Mermaid, dimensionamento.
- [alarmes.md](./references/alarmes.md) — gerenciamento de alarmes, normas, ciclo de vida.
- [normas-ciberseguranca.md](./references/normas-ciberseguranca.md) — verificação de normas
  (fatos já verificados) e fundamentos IEC 62443.
- [latex.md](./references/latex.md) — pipeline e armadilhas verificadas do LaTeX.
