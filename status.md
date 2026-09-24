# status.md — estado do projeto

**Versão da apostila:** 2.4 · **Atualizado em:** 2026-09-24

| Indicador | Valor |
|---|---|
| Capítulos | 14 + glossário |
| Páginas (PDF) | 185 (`latex/apostila.pdf`) |
| Figuras | 61 posições: **24 reais** + 37 placeholders |
| Diagramas Mermaid | 35 (0 falhas, todos na faixa legível) |
| Tabelas legendadas | 38 |
| Estudos de caso | **14 de 14 capítulos** |
| Atividades práticas | 4 (capítulos 10 a 13) |
| Questões de revisão | 103 (6 nos capítulos 1–9; 9 no 14; 10 nos 10–13) |
| Build | 0 erros de LaTeX, 0 `Overfull \hbox`, 0 `Overfull \vbox` |
| Gate editorial | 0 erros, 0 avisos |
| Versão web | `docs/apostila/apostila-scada.html` (16 seções, 35 diagramas, 108 quadros, 24 figuras) |

## Situação dos capítulos

| # | Arquivo | Linhas | Figuras (real/placeholder) | Diagramas | Tabelas | Questões |
|---|---|---|---|---|---|---|
| 1 | `capitulo-01.md` | 242 | 0 / 4 | 2 | 3 | 6 |
| 2 | `capitulo-02.md` | 270 | 0 / 5 | 2 | 2 | 6 |
| 3 | `capitulo-03.md` | 303 | **2** / 1 | 2 | 4 | 6 |
| 4 | `capitulo-04.md` | 299 | **6** / 2 | 2 | 4 | 6 |
| 5 | `capitulo-05.md` | 283 | **3** / 3 | 4 | 3 | 6 |
| 6 | `capitulo-06.md` | 227 | 0 / 5 | 2 | 4 | 6 |
| 7 | `capitulo-07.md` | 439 | **2** / 2 | 2 | 4 | 6 |
| 8 | `capitulo-08.md` | 290 | 0 / 3 | 2 | 6 | 6 |
| 9 | `capitulo-09.md` | 282 | 0 / 4 | 2 | 4 | 6 |
| 10 | `capitulo-10.md` | 376 | **3** / 2 | 3 | 7 | 10 |
| 11 | `capitulo-11.md` | 342 | **3** / 0 | 3 | 6 | 10 |
| 12 | `capitulo-12.md` | 345 | 0 / 3 | 2 | 7 | 10 |
| 13 | `capitulo-13.md` | 345 | **1** / 3 | 4 | 9 | 10 |
| 14 | `capitulo-14.md` | 430 | **4** / 0 | 3 | 8 | 9 |

## Concluído nesta rodada (v2.4)

### 1. Capítulo 14 — Tags, Variáveis, Estados e Eventos

Era a lacuna mais cara da arquitetura-alvo (posição 06): a apostila falava de arquitetura, de
protocolos e de alarmes, mas não dizia o que é um tag, como ele é cadastrado e endereçado, como a
faixa bruta se transforma em unidade de engenharia, nem por que evento não é alarme. O capítulo
novo (430 linhas, 16 páginas no PDF) cobre:

| Seção | Conteúdo |
|---|---|
| 14.1 | O tag como contrato de nomes; tag interno × tag de I/O |
| 14.2 | Campos do cadastro e mapa de memória (tabela de alocação) |
| 14.3 | Tipos, resolução do conversor A/D e escalonamento para unidade de engenharia |
| 14.4 | Representação de discretos e analógicos na IHM |
| 14.5 | Amostragem, varredura e qualidade do dado (`Good`/`Uncertain`/`Bad`) |
| 14.6 | Máquina de estados do equipamento (`stateDiagram-v2`) |
| 14.7 | Evento × alarme, proveniência dos eventos e scripts |
| 14.8 | Comparativo: tag clássico × nó OPC UA × métrica Sparkplug |
| 14.9 | Estudo de caso — mapa de tags de uma estação de bombeamento |

Fontes: `Livro SCADA` §5.3–5.9 (tagnames, animação de objetos, alarmes/eventos, scripts) e
*Sistemas Supervisórios — parte 2* (conceitos e mapa de memória).

### 2. Quatro figuras reais novas (20 → 24)

| Figura | Arquivo | Origem |
|---|---|---|
| 14.1 Dicionário de tagnames | `cap14-dicionario-tagnames.png` | Livro SCADA, p. 99 |
| 14.2 Representação de variável discreta | `cap14-variavel-discreta.png` | Livro SCADA, p. 55 |
| 14.3 Taxa de amostragem inadequada | `cap14-taxa-amostragem.png` | Livro SCADA, p. 68 |
| 14.4 Eventos que disparam scripts | `cap14-eventos.png` | Livro SCADA, p. 72 (figura de Seixas, 2002) |

Todas conferidas na página de origem antes de entrar no texto, extraídas com `pdfimages -png` e
otimizadas com `pngquant`. O capítulo 14 não tem nenhum placeholder de figura.

### 3. Correção normativa no material de origem

O material de origem listava a **IEC 60839** como norma de gerenciamento de alarmes. A IEC 60839
trata de alarme de segurança eletrônica/patrimonial — outro escopo. O capítulo 14 registra a
correção na forma prescrita pela skill (referência histórica → referência atualmente aplicável →
motivo), apontando ANSI/ISA-18.2, IEC 62682, EEMUA 191 e NAMUR NA 102.

### 4. Efeito nos artefatos

- 14 capítulos, 185 páginas, 35 diagramas Mermaid (3 novos, todos na faixa legível: 1,07 / 1,46 / 0,85).
- Glossário: 13 verbetes novos (tag interno, tag de I/O, mapa de memória, escalonamento, unidade de
  engenharia, taxa de amostragem, taxa de varredura, qualidade do dado, máquina de estados, estado
  do equipamento, evento, entre outros).
- `indice.md` e a versão web regenerados; `rebuild.py` descobre o capítulo novo pelo *glob*, sem
  lista a manter.
- O primeiro diagrama de estados (`stateDiagram-v2`) do projeto foi validado pelo pipeline
  (renderiza e entra no PDF sem ajuste).

---

## Concluído na rodada anterior (v2.3)

### 1. Treze figuras reais novas (7 → 20)

Todas conferidas na página de origem antes de entrar no texto, extraídas com `pdfimages -png -f P -l P`
e otimizadas com `pngquant`:

| Figura | Arquivo | Origem |
|---|---|---|
| 3.1 Janela de IHM de um supervisório | `cap03-janela-ihm.png` | Livro SCADA, p. 51 |
| 3.3 Sala de controle com painel convencional | `cap03-sala-convencional.png` | Livro SCADA, p. 15 (Solomon, 2005) |
| 5.3 Arquitetura com Foundation Fieldbus | `cap05-fieldbus-foundation.png` | Livro SCADA, p. 29 |
| 5.6 Integração de múltiplos protocolos | `cap05-servidor-driver.png` | Livro SCADA, p. 25 |
| 7.1 Interface do editor Node-RED | `cap07-editor-node-red.png` | material do curso, p. 13 |
| 7.3 Dashboard Node-RED | `cap07-dashboard-node-red.png` | material do curso, p. 4 |
| 10.3 Sinalização de estado no sinótico | `cap10-sinotico-alarmes.png` | Livro SCADA, p. 135 |
| 10.4 Diagrama de estados do alarme | `cap10-estados-alarme.png` | Livro SCADA, p. 61 |
| 10.5 Registro de eventos de alarme | `cap10-historico-alarmes.png` | Livro SCADA, p. 116 |
| 11.1 Navegação entre telas | `cap11-navegacao-telas.png` | Livro SCADA, p. 83 |
| 11.2 Tendência de processo | `cap11-tendencia-real.png` | Livro SCADA, p. 114 |
| 11.3 Fluxograma P&I do estudo de caso | `cap11-fluxograma-pi.png` | Livro SCADA, p. 89 |
| 13.1 Arquitetura lógica do OPC clássico | `cap13-opc-arquitetura-logica.png` | Livro SCADA, p. 48 |

Isso eleva a cobertura real de figuras de 7 para 20 e reduz os placeholders de 46 para 37.

### 2. Crédito de figura corrigido (erro factual)

As 7 figuras já existentes eram creditadas a **"A. Santos"**. Não existe autor com esse nome no
material de origem: todas as 93 figuras do *Livro SCADA* são "Fonte: Autores". O crédito passou a
nomear **Machado, Pontes e Vianna** nos 20 casos, e a obra entrou na seção de Referências dos
capítulos que a reutilizam (3, 4, 5, 7, 10 e 13).

### 3. Aviso de atualização tecnológica na figura de PROFIBUS

O próprio material de origem anota, na página da figura, que ela **seria alterada**: "na prática a
rede PROFIBUS-DP é substituída pela Ethernet e a FMS suprimida". A apostila usava a figura sem
qualquer ressalva. O capítulo 4 passou a trazer o quadro de **Atualização tecnológica** explicando
o que permanece válido e o que foi descontinuado (regra 8 da skill). No capítulo 5, a afirmação de
que o PROFIBUS é "protocolo proprietário" foi corrigida: é padrão aberto publicado (IEC
61158/61784), com certificação obrigatória para conformidade.

### 4. Estudo de caso em todos os capítulos

Faltava nos capítulos 1, 2, 3, 7, 8 e 9 — que agora têm, cada um, cenário, diagnóstico, decisão de
engenharia e limitações do arranjo. Total: **13 de 13** capítulos atendendo ao mínimo da skill.

### 5. Defeitos de layout do PDF encontrados e corrigidos

| Defeito | Diagnóstico | Correção |
|---|---|---|
| Lista de Figuras com número duplicado ("4.2 Figura 4.3 – …") | o LOF imprime o número automático antes do rótulo manual, e os placeholders não entram no LOF, então as duas contagens divergem | `\captionsetup[figure]{labelformat=empty,listformat=empty}` |
| Caixa "Fonte" em página diferente da figura — **12 das 20** | o `tcolorbox` da fonte não flutua e a figura ia para o topo da página seguinte | o `callouts.lua` funde figura + `> **Fonte:**` numa legenda só (`\caption[curta]{curta. **Fonte:** …}`); Markdown e HTML não mudam |
| `Overfull \vbox` de 261 pt no cap. 11 | figura logo depois de `longtable`: o TeX estima o espaço restante de forma otimista e coloca a figura "aqui", cortada pelo rodapé | `figure` redefinido no template como **não flutuante**, dentro de `minipage` (imagem + legenda indivisíveis), com a Lista de Figuras preservada por `\captionsetup{type=figure}` |

O `\floatplacement{figure}{tbp}` **não** resolveu o terceiro caso — foi a primeira tentativa, testada
e descartada. O diagnóstico e a solução estão em `references/latex.md`.

### 6. Desvios editoriais

- `> 💡 **Nota técnica:**` no capítulo 1 → `> 📌 **Nota:**` (a caixa é classificada pelo emoji; o
  rótulo divergia do tipo).
- MQTT retirado da lista de "sinais de instrumentação" do capítulo 1: é protocolo de integração,
  não sinal de campo.

## Pendências

### 1. Figuras — 37 posições ainda em placeholder (prioridade)

O caminho está provado e agora é mais barato (extrair → conferir na página → inserir → recompilar).
Cobertura atual: **24 reais** de 61 posições. O que falta é cobertura por capítulo e uma decisão de
**direitos autorais** para o material de terceiros:

- **Reutilizável com crédito:** *Livro SCADA*, `supervisorio_scada.pdf`, partes 1 e 2 de
  *Sistemas Supervisórios*, `Node-Red_InterfaceDeSupervisão.pdf`, `IoT.pdf`,
  `IIoT e suas Tecnologias Aderentes.pdf` — material do próprio curso.
- **Evitar reprodução:** `ISA101.pdf`, simpósio ISA-101/Sabesp e `ISA_boas-praticas_SCADAPIMS`
  são material de terceiros (ISA). Os placeholders desses capítulos devem virar figura própria
  (redesenho) ou continuar como direção de arte.
- Capítulos 6, 8 e 9 (15 placeholders) e 1 e 2 (9 placeholders) são os que mais ganhariam com uma
  nova leva: diagramas de IoT/IIoT em `IoT.pdf` e `IIoT e suas Tecnologias Aderentes.pdf` e
  arquiteturas de rede em `supervisorio_scada.pdf`.

### 2. Arquitetura-alvo de 22 capítulos ainda incompleta

Faltam, entre outros: aquisição e tratamento de dados, historiadores e séries temporais, Edge
Computing, integração SCADA+CLP+IoT+Cloud, projetos práticos e IA/Digital Twin como capítulo
próprio. **Tags, variáveis, estados e eventos foi criado nesta rodada (cap. 14).** (O capítulo de
estudos de caso industriais segue ausente como capítulo, mas agora **todos** os capítulos existentes
têm o seu.)

### 3. Atividade prática só nos capítulos 10 a 13

Nos capítulos 1 a 9 o mínimo da skill é atendido sem ela, mas a assimetria é visível. Avaliar se
cada um recebe uma atividade própria ou se a seção passa a ser opcional por natureza de capítulo.

### 4. Decisão de numeração (fechada, documentada)

Os capítulos 10 a 14 foram acrescentados **em sequência** ao final do livro. Na arquitetura-alvo
ele ocupam outras posições (alarmes 17, dashboards 11, ThingsBoard 13, OPC UA 8, MQTT 9, tags e
eventos 6).
Renumerar agora criaria buracos e exigiria reescrever rótulos internos (`Figura N.M`,
`Tabela N.M`) de todos os capítulos existentes. **Decisão:** manter a sequência atual e renumerar
uma única vez, quando o conjunto de capítulos estiver completo — o gate confere a sequência
interna de cada capítulo, e `indice.md` é a única lista de ordem a atualizar.

### 5. `LICENSE.md` descreve outra obra

O arquivo cita "Controladores Lógicos Programáveis" e outro rol de autores. A licença
(CC BY-SA 4.0) e a seção de ressalvas sobre material de terceiros servem, mas a identificação da
obra precisa de confirmação dos autores — **não alterado** por decisão editorial.

### 6. Dívidas técnicas pequenas

- Nomes de arquivo com `_` nas referências não quebram linha; hoje contornado com `\sloppy`.
- Acentos dentro de listagem de código exigem o `literate` do preâmbulo; novos códigos com linha
  acima de 70 colunas voltam a quebrar o alinhamento (o gate avisa).
- `\printindex` está comentado: não há entradas `\index{}` no texto.

## Decisões tomadas

- `apostila/` é a fonte única; `docs/` (PDFs) é imutável; `figuras/`, `latex/` e o HTML gerado são
  artefatos reproduzíveis.
- Figuras são **numeradas à mão** na apostila (placeholders incluídos) e o LaTeX não gera rótulo
  automático de figura; tabelas continuam numeradas pelo LaTeX.
- No **PDF**, a linha `> **Fonte:**` é integrada à legenda da figura (imagem + legenda + fonte num
  bloco indivisível). No Markdown e na **versão web** ela continua sendo um quadro separado.
- Figuras não flutuam: são posicionadas exatamente onde estão no texto, dentro de `minipage`.
- Norma citada só com **edição verificada**; valores de desempenho de alarmes entram como
  "referências usualmente citadas", nunca como exigência normativa.
- Nenhum capítulo mistura material de terceiros sem crédito; figuras de origem ISA ficam como
  direção de arte até serem redesenhadas.
