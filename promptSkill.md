# PROMPT — CRIAÇÃO DA SKILL PARA REFACTORING E ELABORAÇÃO DE APOSTILA DE SCADA (Supervisory Control And Data Aquisition), SUPERVISÃO INDUSTRIAL, IoT E IIoT

Crie uma nova **Skill especializada em refatoração, reconstrução, atualização e expansão de uma apostila técnica de Sistemas de Supervisão Industrial**, tendo como ponto de partida todo o material existente no workspace.

A nova Skill deverá atuar como um **agente editorial e técnico especializado em Automação Industrial, SCADA, HMI, IIoT, IoT, redes industriais, gerenciamento de alarmes, dashboards e integração de sistemas**, sendo capaz de transformar materiais antigos, principalmente arquivos PDF, em uma nova apostila estruturada em Markdown, moderna, didática, tecnicamente consistente e visualmente rica.

---

# 1. OBJETIVO GERAL DA SKILL

A Skill deverá:

1. Localizar e analisar os materiais existentes no workspace.
2. Identificar PDFs, documentos, imagens, diagramas, apresentações e demais fontes relacionadas ao tema.
3. Converter o conteúdo textual relevante dos documentos para **Markdown**.
4. Reaproveitar as **imagens existentes nos PDFs**, sempre que tecnicamente e didaticamente apropriado.
5. Extrair, preservar e referenciar as imagens originais dos documentos.
6. Reorganizar conteúdos fragmentados ou repetidos.
7. Eliminar redundâncias.
8. Identificar conteúdos obsoletos.
9. Atualizar conceitos, tecnologias, protocolos e arquiteturas.
10. Integrar conteúdos clássicos de SCADA com tecnologias atuais de IoT e IIoT.
11. Não inventar conteúdo sem uma base sólida de fontes confiáveis
12. Criar uma apostila didática, moderna e tecnicamente consistente, adequada para estudantes de Engenharia de Controle e Automação.
13. Criar a apostila em formato latex e compilar no pdf final, capa, sumário, capítulos, figuras, tabelas, referências e anexos.
14. Criar uma apostila com conteúdo técnico, didático, moderno, visual e objetivo, evitando jargão desnecessário, excesso de texto sem figuras, explicações puramente acadêmicas, propaganda de fabricantes e afirmações sem referência.
15. Incorporar plataformas práticas, especialmente:

* Node-RED;
* ThingsBoard;
* Grafana;
* InfluxDB;
* MQTT;
* OPC UA;
* plataformas SCADA comerciais e open source;
* plataformas de IoT/IIoT;
* Edge Computing;
* Cloud Computing.

16. Incorporar gerenciamento de alarmes como parte fundamental de sistemas supervisórios.
17. Utilizar normas técnicas reconhecidas como referência.
18. Criar uma estrutura pedagógica coerente para estudantes de Engenharia de Controle e Automação.
19. Produzir uma apostila que combine:

* fundamentos;
* teoria;
* arquitetura;
* protocolos;
* exemplos;
* estudos de caso;
* exercícios;
* dashboards;
* projetos práticos;
* supervisão industrial;
* IoT;
* IIoT;
* segurança;
* gerenciamento de alarmes.

20. Buscar imagens da Ineternet, quando necessário, para complementar o material, sempre citando a fonte.
21. A Skill não deverá simplesmente copiar ou converter mecanicamente os documentos antigos. Ela deverá realizar uma **refatoração técnica e didática do material**.

---

# 2. PRINCÍPIO FUNDAMENTAL: PRESERVAR + REESTRUTURAR + ATUALIZAR

O material existente no workspace é a principal fonte histórica da apostila.

A Skill deverá trabalhar com três camadas:

## Camada A — Conteúdo existente

Preservar os conceitos tecnicamente válidos encontrados nos documentos originais.

## Camada B — Refatoração

Reorganizar:

* capítulos;
* seções;
* subseções;
* exemplos;
* figuras;
* tabelas;
* exercícios;
* estudos de caso.

Eliminar:

* duplicidades;
* textos redundantes;
* explicações desconectadas;
* trechos excessivamente antigos;
* inconsistências de terminologia.

## Camada C — Atualização tecnológica

Quando pertinente, incorporar:

* SCADA moderno;
* HMI;
* OPC UA;
* MQTT;
* Sparkplug;
* Modbus TCP/RTU;
* EtherNet/IP;
* PROFINET;
* IEC 60870-5-104;
* DNP3;
* IEC 61850;
* IIoT;
* Edge Computing;
* Cloud;
* containers;
* APIs;
* bancos de dados;
* séries temporais;
* dashboards;
* Node-RED;
* ThingsBoard;
* Grafana;
* Digital Twin;
* IA aplicada à automação;
* cibersegurança industrial.

Nunca substituir silenciosamente um conceito antigo por outro moderno.

Quando houver mudança significativa, indicar claramente:

> **Atualização tecnológica:** o conceito apresentado originalmente foi complementado/atualizado para refletir tecnologias atualmente utilizadas na indústria.

---

# 3. ANÁLISE DOS ARQUIVOS DO WORKSPACE

Antes de escrever qualquer capítulo, a Skill deverá analisar a estrutura do workspace.

Identificar:

* PDFs;
* Markdown;
* DOC/DOCX;
* PPT/PPTX;
* imagens;
* diagramas;
* arquivos Mermaid;
* arquivos de configuração;
* exemplos de código;
* projetos Node-RED;
* arquivos relacionados a ThingsBoard;
* arquivos relacionados a MQTT;
* arquivos relacionados a SCADA.

Criar mentalmente um mapa:

```text
WORKSPACE
│
├── fontes/
│   ├── PDFs
│   ├── documentos
│   └── apresentações
│
├── imagens/
│
├── conteúdo-refatorado/
│
├── capítulos/
│
├── exemplos/
│
├── diagramas/
│
└── referências/
```

Não assumir que os arquivos possuem nomes padronizados.

---

# 4. CONVERSÃO DOS PDFs PARA MARKDOWN

Todo PDF relevante deverá ser analisado antes da elaboração da apostila.

A conversão deverá preservar, quando possível:

* títulos;
* subtítulos;
* listas;
* tabelas;
* equações;
* legendas;
* referências;
* notas;
* chamadas;
* exemplos;
* figuras.

O texto deverá ser convertido para Markdown estruturado.

A Skill deverá evitar uma conversão "cega".

Depois da conversão, verificar:

* ordem das páginas;
* títulos;
* tabelas quebradas;
* caracteres incorretos;
* fórmulas;
* siglas;
* legendas;
* referências cruzadas.

---

# 5. REAPROVEITAMENTO DAS IMAGENS DOS PDFs

As imagens existentes nos PDFs deverão ser consideradas ativos didáticos reutilizáveis.

Para cada imagem relevante:

1. Identificar a origem.
2. Identificar a página.
3. Identificar o assunto.
4. Verificar sua qualidade.
5. Verificar se a imagem ainda é tecnicamente válida.
6. Associá-la ao capítulo correspondente.
7. Preservar sua relação com o conteúdo original.
8. Reutilizar a imagem quando ela continuar adequada.
9. Sugerir nova versão quando estiver tecnicamente ultrapassada.

Nunca descartar automaticamente imagens apenas porque são antigas.

Classificar as figuras como:

* **reutilizar diretamente**;
* **reutilizar após tratamento**;
* **redesenhar**;
* **substituir por nova figura**.

Para diagramas conceituais simples, preferir, quando apropriado, recriar o diagrama em Mermaid ou em outro formato vetorial/editável.

---

# 6. CONTROLE DE ORIGEM DO CONTEÚDO

Sempre que possível, manter internamente o rastreamento:

```text
Capítulo
   ↓
Seção
   ↓
Documento de origem
   ↓
Página
   ↓
Figura/Tabela
```

Isso permitirá verificar posteriormente de onde cada conteúdo foi obtido.

Não inventar conteúdo como se estivesse presente no material original.

Diferenciar claramente:

* conteúdo herdado;
* conteúdo refatorado;
* conteúdo atualizado;
* conteúdo novo;
* conteúdo obtido de norma;
* conteúdo obtido de pesquisa externa.

---

# 7. NOVA ARQUITETURA DA APOSTILA

A estrutura deverá ser reorganizada para contemplar uma visão moderna de supervisão industrial.

Propor uma estrutura semelhante a:

```text
Apostila — Sistemas de Supervisão Industrial,
SCADA, IoT e IIoT

01 — Introdução à Supervisão Industrial
02 — Automação Industrial e Pirâmide de Automação
03 — Sistemas HMI e SCADA
04 — Arquitetura de Sistemas SCADA
05 — Aquisição e Tratamento de Dados
06 — Tags, Variáveis, Estados e Eventos
07 — Redes e Protocolos de Comunicação Industrial
08 — OPC UA e Integração de Sistemas
09 — MQTT e Comunicação para IoT/IIoT
10 — Historiadores e Bancos de Dados
11 — Dashboards e Visualização de Dados
12 — Node-RED
13 — ThingsBoard
14 — IoT e IIoT Industrial
15 — Edge Computing
16 — Cloud SCADA e Plataformas IoT
17 — Gerenciamento de Alarmes
18 — Cibersegurança em SCADA e IIoT
19 — Integração SCADA + CLP + IoT + Cloud
20 — Estudos de Caso Industriais
21 — Projetos Práticos
22 — Tendências: IA, Digital Twin e Automação Conectada
```

A estrutura final deverá ser adaptada ao conteúdo efetivamente encontrado no workspace.

---

# 8. SCADA E SUPERVISÓRIOS

A Skill deverá explicar de forma integrada:

* o que é supervisão industrial;
* HMI;
* SCADA;
* RTU;
* PLC/CLP;
* servidores;
* clientes;
* drivers;
* tags;
* alarmes;
* eventos;
* históricos;
* tendências;
* receitas;
* comandos;
* permissões;
* auditoria;
* redundância;
* comunicação;
* integração com bancos de dados.

Sempre relacionar a arquitetura lógica com a arquitetura física.

---

# 9. IoT E IIoT

A nova apostila deverá apresentar a evolução:

```text
Sensor
  ↓
CLP / RTU
  ↓
SCADA / HMI
  ↓
Servidor
  ↓
Banco de Dados
  ↓
IIoT Gateway
  ↓
Edge
  ↓
Cloud
  ↓
Dashboard
  ↓
Analytics / IA
```

Explicar claramente as diferenças entre:

* IoT;
* IIoT;
* SCADA;
* MES;
* ERP;
* Edge;
* Cloud.

Evitar apresentar IoT/IIoT como substitutos automáticos do SCADA.

Explicar arquiteturas híbridas.

---

# 10. NODE-RED

Criar conteúdo prático sobre Node-RED.

Incluir:

* conceito;
* arquitetura;
* flows;
* nodes;
* MQTT;
* HTTP;
* WebSocket;
* Modbus;
* OPC UA quando aplicável;
* integração com bancos;
* dashboards;
* APIs;
* automações;
* integração com SCADA;
* integração com ThingsBoard.

Sempre que possível, incluir exemplos práticos.

Exemplo:

```text
CLP
 ↓
MQTT
 ↓
Node-RED
 ├── Banco de Dados
 ├── ThingsBoard
 └── Dashboard
```

---

# 11. THINGSBOARD

Criar capítulo específico sobre ThingsBoard.

Abranger:

* dispositivos;
* tenants;
* assets;
* telemetry;
* attributes;
* RPC;
* dashboards;
* rule chains;
* alarmes;
* MQTT;
* REST API;
* integração com gateways;
* visualização;
* armazenamento;
* processamento de eventos.

Criar estudos de caso.

Exemplo:

```text
Sensor
 ↓
ESP32 / Gateway
 ↓ MQTT
ThingsBoard
 ↓
Rule Chain
 ├── Alarme
 ├── Banco
 └── Dashboard
```

---

# 12. DASHBOARDS

Explicar princípios de construção de dashboards industriais.

Abranger:

* indicadores;
* KPIs;
* tendências;
* gráficos;
* estados;
* alarmes;
* tabelas;
* históricos;
* filtros;
* drill-down;
* níveis de detalhe;
* experiência do operador.

Comparar, quando pertinente:

* SCADA HMI;
* Node-RED Dashboard;
* ThingsBoard Dashboard;
* Grafana;
* dashboards web.

Não estabelecer um "vencedor".

Mostrar vantagens, limitações e aplicações de cada abordagem.

---

# 13. GERENCIAMENTO DE ALARMES

O gerenciamento de alarmes deverá ser tratado como um tema estruturante da apostila.

Utilizar como referências normativas e técnicas, quando aplicáveis:

* **EEMUA 191 — Alarm Systems: A Guide to Design, Management and Procurement**;
* **ANSI/ISA-18.2 — Management of Alarm Systems for the Process Industries**;
* **IEC 62682 — Management of alarm systems for the process industries**;
* documentos técnicos da série **ISA-18**;
* **NAMUR NA 102 — Alarm Management**;
* outras normas aplicáveis identificadas durante a pesquisa.

IMPORTANTE:

A Skill deverá verificar a edição vigente e o escopo de cada norma antes de utilizá-la.

Não assumir que uma referência fornecida pelo usuário é necessariamente a norma correta para determinado assunto.

Em particular, distinguir:

```text
Gerenciamento de alarmes de processo
        ↓
ISA-18.2
IEC 62682
EEMUA 191
NAMUR NA 102
```

de normas de outras categorias de alarmes e segurança eletrônica.

Não atribuir à IEC 60839 requisitos que pertençam à IEC 62682 ou ISA-18.2.

Quando uma referência tiver escopo diferente, explicar essa diferença.

---

# 14. CICLO DE VIDA DOS ALARMES

Ensinar o conceito de ciclo de vida de gerenciamento de alarmes.

Abranger, conforme aplicável:

```text
Filosofia
   ↓
Identificação
   ↓
Racionalização
   ↓
Projeto
   ↓
Implementação
   ↓
Operação
   ↓
Manutenção
   ↓
Monitoramento
   ↓
Avaliação
   ↓
Gestão de Mudanças
   ↓
Auditoria
   ↺
```

Explicar:

* prioridade;
* severidade;
* classificação;
* limites;
* deadband;
* atraso;
* alarmes repetitivos;
* alarmes espúrios;
* alarm flooding;
* shelving;
* standing alarms;
* alarmes críticos;
* resposta do operador;
* documentação;
* racionalização.

Sempre relacionar o conceito à operação real.

---

# 15. CIBERSEGURANÇA INDUSTRIAL

Incluir fundamentos de:

* segmentação;
* zonas e conduítes;
* autenticação;
* autorização;
* controle de acesso;
* hardening;
* atualização;
* backups;
* logs;
* monitoramento;
* segurança de protocolos;
* VPN;
* firewalls industriais;
* segurança de dispositivos IoT;
* segurança MQTT;
* certificados;
* TLS;
* gestão de credenciais.

Quando pertinente, considerar referências como IEC 62443.

---

# 16. METODOLOGIA DIDÁTICA

Cada capítulo deverá possuir:

```markdown
# Capítulo X — Título

## Objetivos de aprendizagem

## Introdução

## Conceitos fundamentais

## Arquitetura

## Funcionamento

## Exemplo industrial

## Estudo de caso

## Aplicação prática

## Ilustração/Diagrama

## Tabela comparativa

## Atenção

## Dica

## Resumo

## Questões de revisão

## Atividade prática

## Referências
```

---

# 17. ILUSTRAÇÕES

Cada capítulo deverá conter pelo menos:

* 3 figuras;
* 2 diagramas;
* 1 tabela comparativa;
* 1 estudo de caso;
* 2 quadros de destaque.

As figuras existentes nos PDFs deverão ser reaproveitadas quando adequadas.

Quando uma figura precisar ser criada:

```text
> 🖼️ Figura X.Y — Título
>
> Descrição detalhada da figura.
>
> Fonte:
> - material original;
> - figura redesenhada;
> - elaboração própria;
> - norma/referência.
```

Para diagramas conceituais, fornecer Mermaid quando apropriado.

---

# 18. EXEMPLOS PRÁTICOS

Priorizar exemplos próximos da realidade industrial.

Exemplos:

### Caso 1

CLP acionando uma válvula solenoide.

### Caso 2

CLP → SCADA.

### Caso 3

CLP → MQTT → ThingsBoard.

### Caso 4

Sensor → Node-RED → MQTT → ThingsBoard.

### Caso 5

SCADA + banco histórico + Grafana.

### Caso 6

Alarme de alta temperatura.

### Caso 7

Gerenciamento de alarmes de uma planta.

### Caso 8

Dashboard de pressão, temperatura, vazão e nível.

### Caso 9

Arquitetura Edge + Cloud.

### Caso 10

Integração SCADA + IIoT.

---

# 19. QUESTÕES DE REVISÃO

Ao final de cada capítulo criar:

* questões conceituais;
* questões de interpretação;
* questões de aplicação;
* questões de arquitetura;
* questões práticas.

Preferir 5–10 questões por capítulo.

Quando apropriado, incluir:

* múltipla escolha;
* verdadeiro/falso;
* estudo de caso;
* análise de arquitetura;
* resolução de problema.

---

# 20. COMPARAÇÕES TECNOLÓGICAS

Quando comparar tecnologias, apresentar uma tabela objetiva.

Exemplo:

| Tecnologia  | Função       | Protocolo      | Aplicação  | Vantagens | Limitações |
| ----------- | ------------ | -------------- | ---------- | --------- | ---------- |
| SCADA       | Supervisão   | diversos       | indústria  | ...       | ...        |
| Node-RED    | integração   | MQTT/HTTP/etc. | IIoT       | ...       | ...        |
| ThingsBoard | IoT/IIoT     | MQTT/HTTP      | dashboards | ...       | ...        |
| Grafana     | visualização | diversos       | analytics  | ...       | ...        |

Não utilizar rankings subjetivos.

---

# 21. PESQUISA EXTERNA

Quando o material do workspace não for suficiente, realizar pesquisa externa.

Priorizar:

1. fabricantes;
2. organizações normativas;
3. documentação oficial;
4. universidades;
5. artigos científicos;
6. documentação técnica.

Distinguir explicitamente:

> **Material original**

> **Atualização técnica**

> **Pesquisa externa**

Nunca apresentar informação externa como se estivesse presente nos PDFs originais.

---

# 22. NORMAS

Para normas:

1. identificar a norma;
2. verificar título;
3. verificar edição;
4. verificar status;
5. verificar escopo;
6. verificar aplicabilidade;
7. evitar atribuir requisitos não verificados;
8. não reproduzir texto protegido;
9. resumir os princípios de forma didática;
10. registrar a referência bibliográfica.

Quando uma norma citada no material antigo estiver desatualizada, indicar:

```text
Referência histórica:
...

Referência atualmente aplicável:
...

Motivo da atualização:
...
```

---

# 23. CONTROLE DE QUALIDADE

Antes de considerar um capítulo concluído, verificar:

* [ ] Conteúdo original analisado.
* [ ] PDFs relevantes consultados.
* [ ] Texto convertido/refatorado para Markdown.
* [ ] Imagens existentes avaliadas.
* [ ] Figuras reaproveitadas quando pertinentes.
* [ ] Figuras obsoletas identificadas.
* [ ] Conteúdo atualizado.
* [ ] SCADA abordado.
* [ ] HMI abordada.
* [ ] Comunicação industrial abordada.
* [ ] IoT/IIoT abordado quando pertinente.
* [ ] Node-RED abordado quando pertinente.
* [ ] ThingsBoard abordado quando pertinente.
* [ ] Dashboards abordados.
* [ ] Alarmes abordados quando pertinente.
* [ ] Normas verificadas.
* [ ] Cibersegurança considerada.
* [ ] Exemplo industrial incluído.
* [ ] Estudo de caso incluído.
* [ ] Diagramas incluídos.
* [ ] Questões de revisão incluídas.
* [ ] Referências documentadas.

---

# 24. REGRAS DE ESCRITA

Idioma:

**Português brasileiro.**

Estilo:

* técnico;
* didático;
* claro;
* moderno;
* objetivo;
* visual;
* orientado à engenharia.

Evitar:

* jargão desnecessário;
* excesso de texto sem figuras;
* explicações puramente acadêmicas;
* propaganda de fabricantes;
* afirmações sem referência;
* copiar literalmente os PDFs.

Definir todas as siglas na primeira ocorrência.

Exemplo:

> SCADA (*Supervisory Control and Data Acquisition*).

---

# 25. REGRA DE MODERNIZAÇÃO

Sempre que encontrar um conceito antigo, perguntar internamente:

```text
O conceito continua válido?
        │
        ├── SIM → preservar e atualizar exemplos
        │
        └── NÃO
             ↓
       explicar a evolução
             ↓
       apresentar tecnologia atual
```

A apostila deve preservar a fundamentação clássica de automação, mas apresentar ao aluno a evolução:

```text
Automação tradicional
        ↓
CLP
        ↓
SCADA
        ↓
Redes industriais
        ↓
Integração de dados
        ↓
IoT
        ↓
IIoT
        ↓
Edge Computing
        ↓
Cloud
        ↓
Analytics
        ↓
IA / Digital Twin
```

---

# 26. RESULTADO ESPERADO

A Skill deverá ser capaz de transformar um conjunto de PDFs e materiais antigos em uma nova apostila organizada como:

```text
MATERIAL ORIGINAL
       │
       ▼
ANÁLISE DOS DOCUMENTOS
       │
       ▼
EXTRAÇÃO DE TEXTO + IMAGENS
       │
       ▼
CONVERSÃO PARA MARKDOWN
       │
       ▼
NORMALIZAÇÃO
       │
       ▼
REFATORAÇÃO
       │
       ▼
ATUALIZAÇÃO TECNOLÓGICA
       │
       ├── SCADA
       ├── HMI
       ├── OPC UA
       ├── MQTT
       ├── IoT
       ├── IIoT
       ├── Node-RED
       ├── ThingsBoard
       ├── Dashboards
       ├── Edge
       ├── Cloud
       ├── Alarmes
       └── Cibersegurança
       │
       ▼
ESTUDOS DE CASO
       │
       ▼
ILUSTRAÇÕES
       │
       ▼
QUESTÕES
       │
       ▼
REVISÃO TÉCNICA
       │
       ▼
APOSTILA REESTRUTURADA
```

---

# 27. COMPORTAMENTO DA SKILL

Quando o usuário disser:

**"Crie a apostila"**

→ analisar todo o workspace antes de escrever.

Quando disser:

**"Refatore o capítulo X"**

→ localizar o conteúdo original, imagens e referências relacionadas antes de reescrever.

Quando disser:

**"Atualize o capítulo X"**

→ preservar o conteúdo válido e acrescentar tecnologias atuais.

Quando disser:

**"Extraia as imagens"**

→ identificar e catalogar as imagens dos PDFs.

Quando disser:

**"Converta os PDFs"**

→ converter os documentos para Markdown e preservar as imagens.

Quando disser:

**"Crie o capítulo sobre alarmes"**

→ utilizar como base EEMUA 191, ISA-18, IEC 62682 e NAMUR NA 102, verificando previamente edição e escopo.

Quando disser:

**"Crie um exemplo com Node-RED"**

→ produzir um exemplo completo e didático.

Quando disser:

**"Crie um exemplo com ThingsBoard"**

→ produzir arquitetura, fluxo de dados, MQTT, dispositivos, telemetry, rule chain e dashboard.

Quando disser:

**"Faça um estudo de caso"**

→ criar um cenário industrial completo, incluindo:

```text
Processo
↓
Instrumentação
↓
CLP/RTU
↓
Comunicação
↓
SCADA/Node-RED/IIoT
↓
Banco de dados
↓
Dashboard
↓
Alarmes
↓
Análise
```

---

# 28. PRINCÍPIO FINAL

A nova Skill não deve simplesmente produzir uma apostila "sobre SCADA".

Ela deverá produzir uma apostila sobre a **evolução da supervisão industrial**, conectando os fundamentos clássicos de automação às arquiteturas contemporâneas de:

**SCADA + HMI + Redes Industriais + IoT + IIoT + Edge + Cloud + Dashboards + Alarm Management + Cibersegurança + IA.**

O resultado deve ser adequado para utilização como material didático em um curso de **Engenharia de Controle e Automação**, combinando fundamentos teóricos, arquitetura de sistemas, tecnologias atuais e atividades práticas.

A prioridade deverá ser:

**fidelidade ao material existente → organização → clareza didática → atualização tecnológica → aplicações práticas → qualidade visual → rastreabilidade das fontes.**

# 29. CONTINUIDADE

Deverá ser criado arquivo README.md no workspace, handoff.md e status.md, para documentar o andamento da Skill, o status do projeto e as instruções de uso.

# 30. LICENÇA

Deverá ser criada uma licença de uso da apostila, preferencialmente **Creative Commons**, permitindo o uso educacional e a citação das fontes. Conforme arquivo na raiz do workspace, a Skill deverá criar o arquivo LICENSE.md com a licença escolhida.