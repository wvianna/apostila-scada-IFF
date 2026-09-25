---

# INSTITUTO FEDERAL FLUMINENSE

## Curso de Engenharia de Controle e Automação

---

# Sistemas SCADA e Supervisórios Industriais

## Apostila Técnica Ilustrada

### Versão 2.6

Atualizada com IIoT, OPC UA, MQTT, Cloud SCADA, alarmes, dashboards, ThingsBoard, Sparkplug, aquisição, historização, borda, integração, projeto e analítica industrial

---

**Autor:** D.Sc. William da Silva Vianna

**Versão:** 2.6
**Público-alvo:** Estudantes de Engenharia de Controle e Automação; Técnicos Industriais  
**Nível:** Intermediário (requer conhecimentos básicos de elétrica e eletrônica)  
**Idioma:** Português brasileiro (pt-BR)

---

## Apresentação

Esta apostila reúne os fundamentos e as tendências dos **Sistemas Supervisórios e SCADA** (*Supervisory Control and Data Acquisition*) aplicados à automação industrial. O material foi desenvolvido para oferecer uma progressão didática — do conceito à implementação — com linguagem acessível, diagramas explicativos e estudos de caso reais.

Os 20 capítulos estão organizados em quatro blocos:

- **Fundamentos (capítulos 1 a 4):** automação industrial, pirâmide de automação e níveis hierárquicos, sistemas supervisórios (SCADA e HMI), arquitetura e componentes.
- **Comunicação, integração e segurança (capítulos 5 a 9 e 13):** redes e protocolos industriais, IIoT, Node-RED, cibersegurança, Cloud SCADA e Digital Twin, OPC UA, MQTT e Sparkplug B.
- **Dados, alarmes e visualização (capítulos 10 a 12 e 14 a 16):** tags, variáveis, estados e eventos; aquisição e tratamento de dados; historiadores e séries temporais; gerenciamento de alarmes; dashboards; ThingsBoard.
- **Borda, nuvem e projeto (capítulos 17 a 20):** edge computing, integração SCADA + CLP + IoT + Cloud, projeto e implantação de um sistema supervisório, IA e analítica industrial.

As normas aparecem onde mudam a decisão de engenharia, não como apêndice teórico: o **gerenciamento de alarmes** segue ANSI/ISA-18.2, IEC 62682, EEMUA 191 e NAMUR NA 102, e a **cibersegurança industrial** se apoia na série IEC 62443.

Cada capítulo abre com objetivos de aprendizagem e fecha com questões de revisão — 159 no total. O corpo do texto traz 47 diagramas Mermaid, 64 tabelas legendadas e 79 posições de figura, 31 delas com reproduções do material de origem (telas de supervisão, arquiteturas de rede, painéis de alarmes, tendências e dashboards). Todos os 20 capítulos têm **estudo de caso**, com cenário, diagnóstico, decisão de engenharia e limitações do arranjo; os capítulos 10 a 13 trazem **atividades práticas**; e o **glossário técnico** em apêndice resolve a terminologia durante a leitura.

Ao final do percurso, o leitor deve ser capaz de especificar, integrar e operar um sistema supervisório completo — e de justificar cada escolha de arquitetura, protocolo, base de dados e política de alarmes.

---

## Sumário

| Capítulo | Título | Página |
|---|---|---|
| 1 | [Introdução à Automação Industrial](./capitulo-01.md) | — |
| 2 | [Pirâmide de Automação e Níveis Hierárquicos](./capitulo-02.md) | — |
| 3 | [Sistemas Supervisórios — SCADA e HMI](./capitulo-03.md) | — |
| 4 | [Arquitetura e Componentes de um Sistema SCADA](./capitulo-04.md) | — |
| 5 | [Redes e Protocolos de Comunicação Industrial](./capitulo-05.md) | — |
| 6 | [IIoT e Tecnologias Emergentes](./capitulo-06.md) | — |
| 7 | [Node-RED como Interface Supervisória](./capitulo-07.md) | — |
| 8 | [Segurança em Sistemas SCADA](./capitulo-08.md) | — |
| 9 | [Tendências: Cloud SCADA e Digital Twin](./capitulo-09.md) | — |
| 10 | [Gerenciamento de Alarmes](./capitulo-10.md) | — |
| 11 | [Dashboards e Visualização de Dados](./capitulo-11.md) | — |
| 12 | [ThingsBoard](./capitulo-12.md) | — |
| 13 | [OPC UA, MQTT e Sparkplug B](./capitulo-13.md) | — |
| 14 | [Tags, Variáveis, Estados e Eventos](./capitulo-14.md) | — |
| 15 | [Aquisição e Tratamento de Dados](./capitulo-15.md) | — |
| 16 | [Historiadores e Séries Temporais](./capitulo-16.md) | — |
| 17 | [Edge Computing na Indústria](./capitulo-17.md) | — |
| 18 | [Integração SCADA + CLP + IoT + Cloud](./capitulo-18.md) | — |
| 19 | [Projeto e Implantação de um Sistema Supervisório](./capitulo-19.md) | — |
| 20 | [IA e Analítica Industrial](./capitulo-20.md) | — |
| — | [Glossário Técnico](./glossario.md) | — |

---

## Como Usar Esta Apostila

- **Leitura sequencial:** Os capítulos estão ordenados do mais fundamental ao mais avançado.
- **Leitura temática:** Cada capítulo é autossuficiente; use o glossário para termos desconhecidos.
- **Elementos visuais:** Cada `> 🖼️ Figura` indica onde inserir uma imagem no documento final.
- **Diagramas Mermaid:** Os blocos `mermaid` podem ser renderizados diretamente no VS Code, GitHub ou Obsidian.
- **Questões de revisão:** Ao final de cada capítulo, para fixação e avaliação.

---

## Convenções

| Símbolo | Significado |
|---|---|
| 🖼️ | Sugestão de figura / fotografia a inserir |
| 💡 | Dica prática ou boa prática |
| ⚠️ | Atenção — ponto crítico |
| 📌 | Nota complementar |
| `Código` | Trecho de configuração ou código |
