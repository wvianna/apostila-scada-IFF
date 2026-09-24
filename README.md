# Sistemas SCADA e Supervisórios Industriais — Apostila Técnica Ilustrada

Apostila do curso de **Engenharia de Controle e Automação** do Instituto Federal Fluminense
(IFF), cobrindo supervisão industrial, SCADA, HMI, redes e protocolos industriais, IoT/IIoT,
Node-RED, gerenciamento de alarmes, dashboards e ThingsBoard — com estudos de caso, diagramas e
atividades práticas.

| | |
|---|---|
| **Versão** | 2.3 |
| **Páginas (PDF)** | 168 |
| **Capítulos** | 13 + glossário |
| **Estudo de caso** | em todos os 13 capítulos |
| **Diagramas** | 32 (Mermaid, renderizados em PDF) |
| **Figuras** | 20 reais (reproduzidas do material de origem, com crédito) + 37 posições com direção de arte |
| **Tabelas** | 30 legendadas |
| **Idioma** | pt-BR |
| **Licença** | Creative Commons BY-SA 4.0 (ver `LICENSE.md`) |

## Estrutura do repositório

```text
promptSkill.md        especificação editorial do projeto (requisitos)
apostila/             FONTE DE VERDADE dos capítulos em Markdown
  indice.md           capa, apresentação e sumário
  capitulo-01..13.md  capítulos
  glossario.md        glossário técnico (PT/EN)
docs/                 PDFs de origem do curso (não editar)
  fontes/             texto convertido + inventário de imagens (gerado)
  apostila/           rebuild.py + HTML gerado (lê de apostila/, não guarda cópias)
figuras/              diagramas Mermaid (.mmd) e figuras renderizadas (.pdf/.png)
latex/                artefatos da compilação (gerado; contém apostila.pdf)
.github/skills/apostila-scada-iiot/   skill que opera este projeto
```

## Como construir

Pré-requisitos: `pandoc`, `pdflatex` (TeX Live), `mmdc` (mermaid-cli) e **Google Chrome** para o
`mmdc`. `latexmk` **não** é usado neste projeto — a compilação é `pdflatex` 3× + `makeindex`.

```bash
# 1. (opcional) converter os PDFs de docs/ para Markdown e inventariar figuras
.github/skills/apostila-scada-iiot/scripts/extrair-fontes.sh

# 2. renderizar os diagramas Mermaid
.github/skills/apostila-scada-iiot/scripts/render-mermaid.sh

# 3. compilar: Markdown -> LaTeX -> PDF  (saída: latex/apostila.pdf)
.github/skills/apostila-scada-iiot/scripts/build-pdf.sh

# 4. gate editorial (mínimos por capítulo, numeração, HTML atualizado)
python3 .github/skills/apostila-scada-iiot/scripts/verificar-estrutura.py

# 5. versão web (lê apostila/ e regenera docs/apostila/apostila-scada.html)
python3 docs/apostila/rebuild.py
```

## Conteúdo

| # | Capítulo |
|---|---|
| 1 | Introdução à Automação Industrial |
| 2 | Pirâmide de Automação e Níveis Hierárquicos |
| 3 | Sistemas Supervisórios — SCADA e HMI |
| 4 | Arquitetura e Componentes de um Sistema SCADA |
| 5 | Redes e Protocolos de Comunicação Industrial |
| 6 | IIoT e Tecnologias Emergentes |
| 7 | Node-RED como Interface Supervisória |
| 8 | Segurança em Sistemas SCADA |
| 9 | Tendências: Cloud SCADA e Digital Twin |
| 10 | Gerenciamento de Alarmes (ISA-18.2, IEC 62682, EEMUA 191, NAMUR NA 102) |
| 11 | Dashboards e Visualização de Dados (Grafana, InfluxDB) |
| 12 | ThingsBoard |
| 13 | OPC UA, MQTT e Sparkplug B |
| A | Glossário Técnico |

## Como trabalhar neste projeto

O trabalho editorial é conduzido pela skill **`apostila-scada-iiot`**
(`.github/skills/apostila-scada-iiot/SKILL.md`), que define o fluxo de refatoração, o
reaproveitamento das figuras dos PDFs, o controle de rastreabilidade das fontes e o gate de
qualidade. Peça diretamente, por exemplo:

- "refatore o capítulo 3 trazendo as figuras do `Livro_SCADA`"
- "crie o capítulo sobre OPC UA"
- "extraia as figuras do PDF de ISA-101"

Estado atual do trabalho, pendências e decisões: [`status.md`](./status.md).
Como continuar: [`handoff.md`](./handoff.md).

## Licença

Distribuída sob **Creative Commons Atribuição–CompartilhaIgual 4.0 Internacional (CC BY-SA 4.0)** —
uso educacional, adaptação e citação permitidos, com atribuição e compartilhamento sob a mesma
licença. Ver [`LICENSE.md`](./LICENSE.md).
