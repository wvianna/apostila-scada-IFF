---

# INSTITUTO FEDERAL FLUMINENSE

## Curso de Engenharia de Controle e Automação

---

# Sistemas SCADA e Supervisórios Industriais

## Apostila Técnica Ilustrada

### Versão 2.5

Atualizada com IIoT, OPC UA, MQTT, Cloud SCADA, alarmes, dashboards, ThingsBoard, Sparkplug, aquisição de dados e historização

---

**Autor:** William da Silva Vianna

**Versão:** 2.5 — Acrescenta os capítulos de aquisição e tratamento de dados e de historiadores e séries temporais  
**Público-alvo:** Estudantes de Engenharia de Controle e Automação; Técnicos Industriais  
**Nível:** Intermediário (requer conhecimentos básicos de elétrica e eletrônica)  
**Idioma:** Português brasileiro (pt-BR)

---

## Apresentação

Esta apostila reúne os fundamentos e as tendências dos **Sistemas Supervisórios e SCADA** (*Supervisory Control and Data Acquisition*) aplicados à automação industrial. O material foi desenvolvido para oferecer uma progressão didática — do conceito à implementação — com linguagem acessível, diagramas explicativos e estudos de caso reais.

A segunda versão incorpora as tecnologias que transformaram o setor na última década: **IIoT** (*Industrial Internet of Things*), protocolos modernos como **OPC UA** e **MQTT**, ferramentas open-source como o **Node-RED** e **Grafana**, além dos paradigmas de **Cloud SCADA**, **Digital Twin** e **cibersegurança industrial**.

A versão 2.1 acrescenta três capítulos de aplicação: **gerenciamento de alarmes** segundo ANSI/ISA-18.2, IEC 62682, EEMUA 191 e NAMUR NA 102; **dashboards e visualização de dados**, com Grafana e InfluxDB; e **ThingsBoard**, com o modelo de entidades, motor de regras, alarmes e integração por MQTT.

A versão 2.2 acrescenta o capítulo de **OPC UA, MQTT e Sparkplug B** — a camada de integração entre equipamento, supervisão e nuvem — e incorpora as primeiras figuras extraídas do material de origem.

A versão 2.3 amplia a **base de figuras** para 20 reproduções do material de origem (telas de supervisão, arquiteturas de rede, Painel de alarmes, tendências e dashboard Node-RED) e fecha uma lacuna do plano original: **todos os capítulos passam a ter estudo de caso**, com cenário, diagnóstico, decisão de engenharia e limitações do arranjo.

A versão 2.4 acrescenta o capítulo de **tags, variáveis, estados e eventos** — a camada de dados que sustenta tudo o que os capítulos anteriores descrevem. Ele trata do cadastro de tag e do mapa de memória, do escalonamento para unidade de engenharia, da taxa de amostragem e da qualidade do dado, das máquinas de estado de equipamento e da distinção entre evento e alarme. Quatro novas figuras do material de origem entram junto: o dicionário de tagnames, a representação de uma variável discreta, o efeito da taxa de amostragem inadequada e o diagrama de eventos que disparam scripts.

A versão 2.5 fecha o ciclo do dado: o capítulo de **aquisição e tratamento** segue a cadeia do fenômeno físico até o valor validado — tipos de sinal, resolução, exatidão, ruído, taxas de varredura de cada elo, filtração, faixa morta e registro da primeira falha; o capítulo de **historiadores e séries temporais** trata do que se decide guardar — tendência real e histórica, compressão por exceção, retenção, agregação e a separação entre histórico de processo, histórico de eventos e trilha de auditoria.

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
