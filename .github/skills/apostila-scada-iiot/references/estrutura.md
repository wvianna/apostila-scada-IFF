# Estrutura, convenções e controle de qualidade

## Sumário atual (medido em 2026-09, versão 2.3)

| Arquivo | Título (`# Capítulo N – ...`) | Linhas | 🖼️ real/placeholder | Mermaid |
|---|---|---|---|---|
| `capitulo-01.md` | Introdução à Automação Industrial | 242 | 0 / 4 | 2 |
| `capitulo-02.md` | Pirâmide de Automação e Níveis Hierárquicos | 270 | 0 / 5 | 2 |
| `capitulo-03.md` | Sistemas Supervisórios — SCADA e HMI | 300 | 2 / 1 | 2 |
| `capitulo-04.md` | Arquitetura e Componentes de um Sistema SCADA | 296 | 6 / 2 | 2 |
| `capitulo-05.md` | Redes e Protocolos de Comunicação Industrial | 280 | 3 / 3 | 4 |
| `capitulo-06.md` | IIoT e Tecnologias Emergentes | 227 | 0 / 5 | 2 |
| `capitulo-07.md` | Node-RED como Interface Supervisória | 437 | 2 / 2 | 2 |
| `capitulo-08.md` | Segurança em Sistemas SCADA | 290 | 0 / 3 | 2 |
| `capitulo-09.md` | Tendências: Cloud SCADA e Digital Twin | 282 | 0 / 4 | 2 |
| `capitulo-10.md` | Gerenciamento de Alarmes | 375 | 3 / 2 | 3 |
| `capitulo-11.md` | Dashboards e Visualização de Dados | 342 | 3 / 0 | 3 |
| `capitulo-12.md` | ThingsBoard | 345 | 0 / 3 | 2 |
| `capitulo-13.md` | OPC UA, MQTT e Sparkplug B | 345 | 1 / 3 | 4 |
| `capitulo-14.md` | Tags, Variáveis, Estados e Eventos | 430 | 4 / 0 | 3 |
| `indice.md` | capa + apresentação + sumário | 73 | 0 | 0 |
| `glossario.md` | glossário técnico | 300 | 0 | 0 |

Total: 61 posições de figura — **24 reais, 37 placeholders** — e 35 diagramas Mermaid.
Versão declarada: **2.4**. Todos os 14 capítulos têm estudo de caso; a atividade prática
existe nos capítulos 10 a 13.

## Arquitetura-alvo (22 capítulos, `promptSkill.md` §7)

A coluna "situação" vem do **sumário** (`indice.md`) e da amostragem de conteúdo —
confirmar lendo o capítulo antes de decidir refatorar ou criar.

| Alvo | Situação no workspace | Ação |
|---|---|---|
| 01 Introdução à Supervisão Industrial | cap. 1 e 2 (parcial) | refatorar/fundir |
| 02 Automação Industrial e Pirâmide | cap. 2 | atualizar (ISA-95/IEC 62264, Edge) |
| 03 HMI e SCADA | cap. 3 | atualizar (ISA-101, HMI moderno) |
| 04 Arquitetura SCADA | cap. 4 | atualizar (virtualização, containers, redundância) |
| 05 Aquisição e Tratamento de Dados | disperso no cap. 4 | **criar** |
| 06 Tags, Variáveis, Estados e Eventos | **cap. 14** (criado em 2026-09) | feito |
| 07 Redes e Protocolos Industriais | cap. 5 | atualizar (TSN, PROFINET, EtherNet/IP) |
| 08 OPC UA e Integração de Sistemas | **cap. 13** (com MQTT/Sparkplug) | feito; avaliar separar em capítulo próprio |
| 09 MQTT e Comunicação IoT/IIoT | **cap. 13** (com OPC UA/Sparkplug) | feito; avaliar separar em capítulo próprio |
| 10 Historiadores e Bancos de Dados | parcial no cap. 4 (`Servidor de Historização`) e no cap. 11 | **criar** (séries temporais) |
| 11 Dashboards e Visualização | **cap. 11** | feito |
| 12 Node-RED | cap. 7 | refatorar (fluxos de exemplo, boas práticas) |
| 13 ThingsBoard | **cap. 12** | feito |
| 14 IoT e IIoT Industrial | cap. 6 | refatorar (IoT × IIoT × SCADA) |
| 15 Edge Computing | ausente | **criar** |
| 16 Cloud SCADA e Plataformas IoT | cap. 6 e 9 (parcial) | refatorar |
| 17 Gerenciamento de Alarmes | **cap. 10** | feito → [alarmes.md](./alarmes.md) |
| 18 Cibersegurança em SCADA e IIoT | cap. 8 | refatorar (IEC 62443 por zonas) |
| 19 Integração SCADA + CLP + IoT + Cloud | ausente | **criar** |
| 20 Estudos de Caso Industriais | ausente como capítulo; **há um estudo de caso em cada capítulo** | **criar** (se ainda fizer sentido) |
| 21 Projetos Práticos | ausente | **criar** |
| 22 IA, Digital Twin e Automação Conectada | cap. 9 (parcial) | refatorar |
| Anexos | `glossario.md` | criar: normas com edição/ano, práticas, bibliografia |

A ordem final deve ser adaptada ao material efetivamente encontrado — o sumário acima é
hipótese de trabalho, não imposição.

## Esqueleto de capítulo (`promptSkill.md` §16)

```markdown
# Capítulo N – Título

## Objetivos de Aprendizagem
## Introdução
## N.1 Conceitos fundamentais
## N.2 Arquitetura
## N.3 Funcionamento
## N.4 Exemplo industrial
## N.5 Estudo de caso
## N.6 Aplicação prática
## N.7 Tabela comparativa
## Resumo
## Questões de Revisão
## Referências
```

Os 13 capítulos atuais seguem um recorte mais enxuto (Objetivos → seções numeradas →
`Resumo` → `Questões de Revisão` → `Referências`, verificado nos 13 arquivos), com `Estudo de Caso`
antes do `Resumo` em **todos** eles — nos capítulos 10 a 13 há também `Atividade prática`.
Ao refatorar, manter essa ordem.

## Convenções verificadas (seguir, não reinventar)

- Título: `# Capítulo 3 – Sistemas Supervisórios — SCADA e HMI` (travessão `–` curto; `—` só
  dentro do título).
- Seções: `## 3.2 Funções Principais de um SCADA`, subseções `### 3.2.1 Aquisição de Dados`.
- Sigla na primeira ocorrência: `**SCADA** (*Supervisory Control and Data Acquisition* —
  Controle Supervisório e Aquisição de Dados)`.
- Tabela: linha em negrito `**Tabela 3.1 – Comparativo SCADA × DCS × HMI Local**` antes da tabela.
- Quadros de destaque (**exatamente 4 emojis**, nada de criar novos — o `rebuild.py` classifica
  por eles):
  - `> 📌 **Nota:** ...`
  - `> ⚠️ **Atenção:** ...`
  - `> 💡 **Dica:** ...`
  - `> 🖼️ **[Figura N.M – Título]**` + linha em itálico com a direção de arte/fonte
- Separador `---` entre blocos de seção.
- Diagrama: bloco ` ```mermaid ` (renderiza no VS Code/GitHub e vira PDF no LaTeX).
- Toda lista de código em cerca com linguagem (`bash`, `json`, `python`, `text`).

## Registro de capítulo novo ou renomeado

1. `apostila/<arquivo>.md` — conteúdo.
2. `apostila/indice.md` — linha na tabela do sumário (é dela que o HTML tira a navegação).
3. HTML: `python3 docs/apostila/rebuild.py` (lê `apostila/`, preserva o CSS/JS do HTML).
4. `apostila/glossario.md` — termos novos, em ordem alfabética.
5. LaTeX — automático: `build-pdf.sh` reescreve `latex/manifest.tex` a partir de
   `apostila/capitulo-*.md`.
6. `status.md` e `handoff.md`.

## Mínimos visuais por capítulo (§17)

3 figuras · 2 diagramas · 1 tabela comparativa · 1 estudo de caso · 2 quadros de destaque.

## Exemplos práticos prioritários (§18)

Válvula solenoide via CLP · CLP→SCADA · CLP→MQTT→ThingsBoard · sensor→Node-RED→MQTT→ThingsBoard ·
SCADA+historizador+Grafana · alarme de alta temperatura · gestão de alarmes de uma planta ·
dashboard de pressão/temperatura/vazão/nível · arquitetura Edge+Cloud · integração SCADA+IIoT.

Cada exemplo entrega: diagrama (Mermaid), sequência de dados, configuração mínima, o que
observar no resultado e as limitações do arranjo.

## Questões de revisão (§19)

5–10 por capítulo, misturando: conceitual, interpretação, aplicação, arquitetura e prática
(múltipla escolha, verdadeiro/falso, análise de arquitetura, resolução de problema).
Toda questão discursiva precisa de resposta esperada em tópicos — evita ambiguidade na correção.

## Tabela comparativa padrão (§20)

```markdown
| Tecnologia | Função | Protocolo | Aplicação | Vantagens | Limitações |
|---|---|---|---|---|---|
```

Sem ranking subjetivo e sem "vencedor".

## Controle de qualidade (§23) — antes de fechar o capítulo

- [ ] Fontes originais consultadas (PDF, página conferida).
- [ ] Texto convertido/refatorado para Markdown; tabelas conferidas na origem.
- [ ] Imagens dos PDFs avaliadas e classificadas; figuras reaproveitadas quando pertinentes.
- [ ] Conteúdo atualizado; conceito antigo preservado ou evolução explicada.
- [ ] SCADA/HMI, comunicação industrial, IoT/IIoT e cibersegurança tratados quando pertinentes.
- [ ] Node-RED, ThingsBoard e dashboards tratados quando pertinentes.
- [ ] Alarmes tratados (norma correta, escopo verificado).
- [ ] Exemplo industrial, estudo de caso, diagramas e questões incluídos.
- [ ] Referências documentadas (norma, fabricante, documentação oficial, artigo).
- [ ] `verificar-estrutura.py` sem avisos novos; `build-pdf.sh` sem erro e sem `Overfull \vbox`.
