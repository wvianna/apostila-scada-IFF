# Capítulo 4 – Arquitetura e Componentes de um Sistema SCADA

## Objetivos de Aprendizagem

Ao final deste capítulo, o leitor será capaz de:

- Identificar e descrever os componentes físicos e lógicos de uma arquitetura SCADA.
- Compreender as funções da MTU, RTU e servidor de dados.
- Distinguir arquiteturas monolíticas, distribuídas e redundantes.
- Dimensionar os elementos de uma arquitetura SCADA para um cenário típico.

---

## 4.1 Componentes de uma Arquitetura SCADA

Uma arquitetura SCADA típica combina dispositivos de campo e controle, redes, serviços de aquisição e
supervisão, clientes de operação e, quando requerido, historiadores e serviços de integração. A
figura resume uma configuração possível; os nomes MTU e RTU são mais comuns em telecontrole e não
representam componentes obrigatórios em toda arquitetura moderna.

```mermaid
graph TD
    subgraph Campo
        RTU1[RTU / CLP #1]
        RTU2[RTU / CLP #2]
        S[Sensores e Atuadores]
    end
    subgraph "Rede de Comunicação"
        NET[Fibra / Rádio / 4G / Ethernet]
    end
    subgraph "Centro de Controle"
        MTU[Servidor SCADA / MTU]
        HIST[Servidor de Histórico]
        WEB[Servidor Web / Thin Client]
        HMI1[Estação Operador 1]
        HMI2[Estação Operador 2]
    end
    S --> RTU1 & RTU2
    RTU1 & RTU2 --> NET
    NET --> MTU
    MTU --> HIST
    MTU --> WEB
    MTU --> HMI1 & HMI2
```

![Figura 4.1 – Arquitetura básica de um sistema SCADA](../figuras/cap04-arquitetura-basica.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 22 (Machado, Pontes e Vianna, reproduzida com crédito).

A estação de supervisão comunica-se pelos meios RS-485, RS-422, RS-232 ou Ethernet e conversa
com o hardware de controle, que por sua vez lê sensores e transmissores e aciona os atuadores
sobre o processo.

---

## 4.2 RTU — Unidade Terminal Remota

A **RTU** (*Remote Terminal Unit*) é uma unidade de telecontrole instalada em local remoto. Em
geral, reúne entradas/saídas, comunicação e capacidade de executar lógica local, mas os recursos
variam por modelo e aplicação. Suas funções podem incluir:

1. **Coletar** dados de sensores e instrumentos.
2. **Executar** lógica local, quando prevista no projeto.
3. **Transmitir** dados ao centro por um protocolo de comunicação.
4. **Receber** comandos e encaminhá-los às saídas, conforme permissões e intertravamentos.

As quantidades de canais, faixas elétricas, protocolos, alimentação e temperatura admissível são
características do modelo escolhido, não uma definição geral de RTU; devem ser conferidas na folha
de dados.

### 4.2.1 Módulo de I/O remoto não é necessariamente uma RTU

Um **módulo de I/O remoto** (*remote I/O*) concentra canais distribuídos e os comunica a um
controlador. Em geral, não executa por si só a lógica de controle nem desempenha as funções de
telemetria e operação autônoma de uma RTU. Se apenas expande a E/S de um CLP, é um módulo remoto; se
também adquire dados, comunica-se com o centro e executa funções locais, pode atuar como RTU. Há
equipamentos híbridos: verifique a documentação e o comportamento durante a perda de comunicação.

### 4.2.2 RTU vs. CLP em telecontrole

CLPs podem atender a aplicações de telecontrole, assim como RTUs podem executar lógicas locais. A
escolha deve comparar consumo do conjunto, autonomia, protocolos, manutenção, expansão de E/S,
requisitos ambientais e comportamento durante falhas. Baixo consumo ou certificação ambiental não
são garantidos apenas pelo rótulo RTU; confirme as características do modelo para o local de uso.

> 💡 **Dica:** Em aplicações de telemetria de água e saneamento, é comum encontrar RTUs com comunicação GPRS/4G incorporada, alimentadas por painel solar e bateria, operando sem intervenção por meses. Fabricantes como Advantech, Emerson (Bristol) e SEL atendem bem esse nicho.

---

## 4.3 MTU — Unidade Terminal Mestre

A **MTU** (*Master Terminal Unit*) é um termo tradicional para a unidade mestre de um sistema de
telecontrole. Em arquiteturas atuais, suas funções podem estar distribuídas entre servidores
SCADA, front-ends de comunicação e outros serviços. Quando o termo é usado, costuma identificar o
componente que coordena a comunicação com RTUs e concentra dados e comandos:

- **Polling:** interroga periodicamente cada RTU/CLP para coletar dados.
- **Banco de dados em tempo real (RTDB):** mantém na memória o estado atual de todas as variáveis do sistema.
- **Processamento de alarmes:** avalia condições de alarme e notifica os operadores.
- **Registro de eventos:** armazena com timestamp cada mudança de estado e alarme.
- **Execução de controle supervisório:** processa os comandos dos operadores e os encaminha às RTUs.
- **Interface com clientes HMI:** serve dados às estações de operação e thin clients.

### 4.3.1 Redundância da MTU

Para requisitos elevados de disponibilidade, a arquitetura pode incluir redundância **ativo-passivo**
ou serviços **ativo-ativos**. O comportamento depende do produto, da topologia e do que está
sincronizado; redundância de servidor, isoladamente, não garante continuidade de todos os serviços:

- **Ativo-passivo:** um nó atende às funções principais e outro fica pronto para assumir. Verifique o que é replicado, os critérios de detecção e o tempo de comutação especificado e testado.
- **Ativo-ativo:** os nós atendem simultaneamente a serviços ou cargas definidas pela arquitetura. A distribuição de clientes e a recuperação de sessão variam entre implementações.

> 🖼️ **[Figura 4.2 – Configuração redundante de servidores SCADA]**
> *Diagrama mostrando dois servidores SCADA (Primário e Backup) conectados por link dedicado de sincronização. As RTUs de campo conectam-se aos dois servidores. Os clientes HMI recebem dados do servidor ativo. Seta pontilhada indicando o failover automático.*

---

## 4.4 Servidor de Historização (Historiador)

O **historiador de processo** é um banco de dados especializado em armazenar séries temporais de variáveis industriais com alta eficiência de compressão e acesso.

### 4.4.1 Por que não usar SQL convencional?

Bancos relacionais podem armazenar dados temporais e são adequados a várias aplicações industriais.
Em altas taxas de ingestão, muitos anos de retenção ou consultas repetidas por intervalo, um
historiador especializado ou banco de séries temporais pode reduzir o esforço de armazenamento,
compressão e consulta. A escolha depende da escala, dos requisitos de integridade e das competências
da equipe:

- Uma planta com 10.000 tags coletados a cada segundo gera **864 milhões de registros por dia**.
- Sem particionamento, compressão e índices adequados, o volume pode aumentar o custo de armazenamento e manutenção.
- Consultas temporais repetidas podem exigir modelagem e otimização que soluções especializadas já oferecem.

Isso não significa que todo banco SQL seja inadequado: particionamento, extensões para séries
temporais e infraestrutura dimensionada podem atender ao caso. Compare com uma carga representativa
e consultas reais.

### 4.4.2 Soluções de Historização

| Produto | Tipo | Empresa | Diferencial |
|---|---|---|---|
| **AVEVA PI System** | Comercial | AVEVA | Padrão da indústria de O&G; ecossistema amplo (PI Vision, PI AF) |
| **Honeywell Uniformance PHD** | Comercial | Honeywell | Integrado ao Experion |
| **InfluxDB** | Open-source | InfluxData | Alta performance; linha do tempo nativa; integração com Grafana |
| **TimescaleDB** | Open-source | Timescale | Extensão PostgreSQL para séries temporais |
| **Prometheus** | Open-source | CNCF | Focado em métricas de infraestrutura; integra com Grafana |

> 📌 **Nota:** O **AVEVA PI System** é o historiador mais utilizado na indústria de petróleo, gás e energia elétrica no Brasil e no mundo. Conhecer sua estrutura de atributos (PI AF — Asset Framework) é uma competência valorizada no mercado.

---

## 4.5 Estações de Operação e Thin Clients

As **estações de operação** são os computadores onde os operadores monitoram o processo e executam comandos. Podem ser:

- **Fat clients (clientes completos):** PC com software SCADA instalado — alto desempenho, menor dependência de rede.
- **Thin clients:** estações sem disco local que executam a interface SCADA a partir de um servidor (Terminal Server ou Citrix). Mais fáceis de manter e atualizar.
- **Web clients:** acesso via navegador (Chrome, Edge) sem instalação. Tendência predominante em plataformas modernas como Ignition.
- **Mobile clients:** aplicativos iOS/Android para supervisão em campo ou acesso remoto.

---

## 4.6 Infraestrutura de Comunicação

A rede de comunicação é o sistema circulatório do SCADA. Suas características determinam a confiabilidade e o desempenho do sistema.

### 4.6.1 Meios Físicos

| Meio | Vantagem | Limitação | Aplicação |
|---|---|---|---|
| **Fibra ótica** | Alta velocidade, imune a EMI | Custo de instalação | Redes industriais críticas |
| **Ethernet par trançado** | Baixo custo, fácil instalação | Distância ~100 m | Ambiente de controle local |
| **Rádio UHF/VHF** | Sem infraestrutura física | Sujeito a interferência | Áreas remotas sem cabeamento |
| **4G/5G** | Cobertura ampla, fácil implantação | Custo recorrente, latência variável | RTUs remotas, telemetria |
| **Satélite** | Cobertura global | Alta latência, custo elevado | Offshore, locais sem cobertura celular |

### 4.6.2 Topologias de Rede

![Figura 4.3 – Arquitetura de rede de campo com PROFIBUS e supervisão remota](../figuras/cap04-rede-profibus.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 30 (Machado, Pontes e Vianna, reproduzida com crédito).

Observe a topologia em barramento nos dois níveis: PROFIBUS DP entre CLPs e instrumentos,
PROFIBUS PA no nível dos transmissores, e uma estação de supervisão que também é alcançada
pela rede corporativa.

> ⚠️ **Atualização tecnológica:** o próprio material de origem anota, na página da figura, que
> ela **seria alterada**: na prática, o PROFIBUS DP passou a ser substituído por **Ethernet**
> industrial (PROFINET ou EtherNet/IP) no nível de controle, e o PROFIBUS FMS foi descontinuado.
> O barramento PROFIBUS permanece relevante onde já está instalado — sobretudo na camada de
> instrumentação (PROFIBUS PA) —, não como escolha para projetos novos. A figura é mantida como
> registro de uma arquitetura real de campo, e não como recomendação de projeto.

---

## 4.7 Comparativo de Arquiteturas SCADA

A escolha da arquitetura é uma decisão de engenharia de disponibilidade: quanto mais crítico o
processo, mais a redundância deixa de ser opcional.

```mermaid
flowchart TB
    subgraph MONO["Monolitica: um servidor"]
        direction TB
        M1["Cliente do operador"] --> M2["Servidor unico"]
    end
    subgraph RED["Redundante: primario e reserva"]
        direction TB
        R1["Clientes"] --> R2["Servidor primario"]
        R2 --> R3["Servidor reserva"]
    end
    MONO ~~~ RED
```

**Tabela 4.1 – Arquiteturas SCADA e suas características**

| Arquitetura | Descrição | Vantagens | Desvantagens | Indicada para |
|---|---|---|---|---|
| **Monolítica** | Um único servidor SCADA | Simples, baixo custo | Ponto único de falha | Pequenas plantas, projetos piloto |
| **Cliente-Servidor** | Servidor central + múltiplos clientes | Escalável, acesso multiusuário | Exige rede confiável | Plantas médias e grandes |
| **Distribuída** | Múltiplos servidores por área ou site | Falha isolada por área | Mais complexa de integrar | Múltiplos sites |
| **Redundante** | Servidor primário + backup automático | Alta disponibilidade (HA) | Custo dobrado | Infraestruturas críticas |
| **Cloud SCADA** | Servidor hospedado na nuvem | Acesso global, sem hardware local | Latência, segurança de dados | Supervisão distribuída, SaaS |

As três variantes abaixo são as arquiteturas históricas que a tabela resume: com CLP, com
controladores dedicados e com sistema de aquisição de dados. Elas continuam aparecendo em campo,
mesmo quando o CLP é a escolha padrão.

![Figura 4.4 – Arquitetura SCADA com uso de CLP](../figuras/cap04-arquitetura-clp.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 26 (Machado, Pontes e Vianna, reproduzida com crédito).

Com o CLP, o controle fica concentrado no controlador e a supervisão deixa de conversar
diretamente com os instrumentos: ela fala com o CLP pela rede de comunicação.

![Figura 4.5 – Arquitetura com controladores single-loop e multi-loop](../figuras/cap04-arquitetura-single-multiloop.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 27 (Machado, Pontes e Vianna, reproduzida com crédito).

Cada controlador dedicado fecha uma ou mais malhas, e a supervisão lê e escreve setpoints
sobre o barramento RS-485.

![Figura 4.6 – Arquitetura com sistema de aquisição de dados](../figuras/cap04-arquitetura-daq.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 28 (Machado, Pontes e Vianna, reproduzida com crédito).

No DAQ não há controle pelo sistema supervisório: ele apenas adquire, apresenta e registra.

![Figura 4.7 – Tempo de resposta de um sistema SCADA](../figuras/cap04-tempo-resposta.png)

> **Fonte:** *Livro SCADA — versão para análise*, p. 33 (Machado, Pontes e Vianna, reproduzida com crédito).

O tempo total de resposta é a soma das parcelas: interface homem-máquina, driver de comunicação,
sistema operacional, hardware de controle e E/S. É por isso que o tempo medido na tela nunca é
igual ao tempo de varredura do CLP.

---

## 4.8 Estudo de Caso — SCADA para Sistema de Abastecimento de Água

**Contexto:** Uma companhia de saneamento opera 35 estações de bombeamento distribuídas em uma cidade de médio porte, com distâncias de até 80 km do centro de controle.

**Desafio:** Monitorar em tempo real nível dos reservatórios, pressão nas redes de distribuição e status das bombas; detectar vazamentos; gerar relatórios de consumo para a concessionária reguladora.

**Solução adotada:**

- **Campo:** RTUs alimentadas por energia solar + bateria, com medidores de vazão eletromagnéticos, transmissores de pressão e nível ultrassônico.
- **Comunicação:** Link 4G (operadora) com VPN criptografada; backup via rádio UHF para estações críticas.
- **SCADA:** Servidor central com ScadaBR (open-source) + módulo de relatórios. Interface web para acesso da equipe de operação e manutenção via tablets.
- **Histórico:** InfluxDB para séries temporais + Grafana para dashboards de consumo e OEE das bombas.

**Resultados esperados no cenário didático:** maior visibilidade do estado das estações, priorização mais rápida de falhas e disponibilidade de dados históricos para investigar desvios. Não são métricas de uma implantação real; estimativas de economia ou tempo de resposta exigiriam dados de referência e validação em campo.

> 🖼️ **[Figura 4.8 – Arquitetura do SCADA de saneamento]**
> *Diagrama da arquitetura completa do estudo de caso: mapa geográfico esquemático da cidade com as 35 estações; link 4G até o centro de controle; servidor SCADA, InfluxDB e Grafana; estações de operação e acesso mobile.*

---

## Resumo

- Uma arquitetura SCADA integra campo/controle, comunicação, aquisição e serviços de supervisão; MTU e RTU são termos tradicionais de telecontrole, não blocos obrigatórios em todos os sistemas.
- **RTUs** podem reunir E/S, comunicação e lógica local; módulos de I/O remoto normalmente expandem os canais de um controlador.
- A escolha entre historiador dedicado, banco de séries temporais ou relacional depende de volume, retenção, integridade, consulta e capacidade de operação.
- A arquitetura deve ser dimensionada conforme criticidade: desde monolítica (simples) até redundante com failover automático (infraestruturas críticas).
- A comunicação pode usar fibra, Ethernet, rádio ou 4G — cada meio com trade-offs de custo, velocidade e confiabilidade.

---

## Questões de Revisão

**Conceituais:**

1. Qual é a diferença entre MTU e RTU em um sistema SCADA?
2. Por que bancos de dados relacionais convencionais são inadequados para historização de dados de processo industrial?
3. Quais são as diferenças entre as arquiteturas SCADA cliente-servidor e cloud SCADA?

**Práticas:**

4. Uma planta petroquímica opera 24 horas por dia, 7 dias por semana, com zero tolerância a paradas não programadas do sistema de supervisão. Qual arquitetura SCADA você recomendaria? Descreva os componentes de redundância necessários.
5. Para um sistema com 500 RTUs coletando 20 variáveis cada uma, a cada 10 segundos, calcule o volume de dados históricos gerado por dia e por ano. Qual solução de historização você escolheria?

**Desafio:**

6. Projete uma arquitetura SCADA para uma fazenda com 10 pivôs de irrigação localizados em área sem cobertura de fibra. Defina: meios de comunicação, equipamento de campo, servidor e interface de supervisão.

---

## Referências

- BOYER, S. A. *SCADA: Supervisory Control and Data Acquisition*. 4. ed. ISA, 2010.
- INFLUXDATA. *InfluxDB Documentation*. Disponível em: docs.influxdata.com.
- AVEVA. *PI System Overview*. Disponível em: aveva.com/en/products/pi-system/.
- IEC 60870-5: *Telecontrol Equipment and Systems*. IEC, 2006.
- MACHADO, C. F. B.; PONTES, M. O.; VIANNA, W. S. *SCADA — Supervisory Control and Data
  Acquisition: sistemas de supervisão e aquisição de dados para automação*. (Material de origem desta
  apostila; figuras das arquiteturas dos autores, reproduzidas com crédito.)
