# Glossário Técnico — Sistemas SCADA e Supervisórios Industriais

> **Como usar:** As siglas são expandidas na primeira ocorrência de cada capítulo. Este glossário reúne todos os termos para consulta rápida.

---

## A

**Air Gap**  
Isolamento físico completo entre uma rede (geralmente OT) e outras redes externas. Historicamente usado em sistemas SCADA críticos para impedir acesso remoto — mas eliminado pela convergência TI/OT.

**AMQP** (*Advanced Message Queuing Protocol*)  
Protocolo de mensageria orientado a filas, similar ao MQTT mas com mais recursos de roteamento. Usado em middlewares enterprise como RabbitMQ.

**Analytics Industrial**  
Conjunto de técnicas de análise de dados aplicadas ao ambiente industrial: estatística descritiva, detecção de anomalias, modelos preditivos.

**Alarme**  
Evento que exige **resposta do operador** dentro de um tempo definido. Se não há ação possível, não é alarme: é registro.

**Alarme fixo** (*standing alarm*)  
Alarme que permanece ativo por longos períodos sem ação possível, geralmente por falha de instrumento ou de configuração.

**Alarme obsoleto** (*stale alarm*)  
Alarme cuja condição já cessou mas que permanece ativo por falha de projeto ou de comunicação.

**Alarme fugaz** (*fleeting alarm*)  
Alarme que dispara e limpa em poucos segundos, normalmente por transitório de partida; combate-se com atraso de confirmação.

**Alarm flooding (inundação de alarmes)**  
Rajada de alarmes em curto intervalo que ultrapassa a capacidade de leitura e de resposta do operador, escondendo a causa raiz.

**Anomalia**  
Comportamento estatisticamente diferente do padrão observado. Não é sinônimo de falha: pode ser regime novo, produto diferente ou condição ambiental. Serve como convite à investigação, não como alarme.

**Atributo (ThingsBoard)**  
Valor de estado associado a uma entidade, em que o último valor substitui o anterior (ao contrário da telemetria, que preserva o histórico). Escopos: servidor, compartilhado e cliente.

**Atuador**  
Dispositivo que converte um sinal elétrico em ação física sobre o processo: válvulas, motores, relés, pistões pneumáticos.

---

## B

**Baseline (linha de base)**  
Referência de comportamento normal de um ativo ou processo, obtida do próprio histórico, com média, dispersão e correlações. Sem baseline, não há como afirmar que um valor está anormal.

**BPCS** (*Basic Process Control System*)  
Sistema de controle principal de uma planta — geralmente o DCS ou CLP. Distinto do SIS (sistema de segurança).

**Broker MQTT**  
Servidor intermediário no padrão MQTT que recebe mensagens dos publishers e as distribui aos subscribers inscritos nos tópicos correspondentes.

---

## C

**CapEx** (*Capital Expenditure*)  
Investimento de capital em ativos físicos duráveis — servidores, hardware, licenças perpétuas.

**Chattering (alarme repetitivo)**  
Alarme que dispara e limpa repetidamente em torno do limite, consumindo a atenção do operador; combate-se com faixa morta e atraso de confirmação.

**CIA** (*Confidentiality, Integrity, Availability*)  
Tríade clássica de segurança da informação: Confidencialidade, Integridade e Disponibilidade.

**CIP** (*Common Industrial Protocol*)  
Protocolo de aplicação usado pelo EtherNet/IP e DeviceNet para comunicação industrial Rockwell/ODVA.

**Ciclo de vida de um projeto SCADA**  
Sequência de fases — definição, seleção, projeto, implementação, testes preliminares, aceitação e manutenção — em que cada fase termina com um produto verificável.

**CLP** (*Controlador Lógico Programável*)  
Computador industrial programável para controle de sequências lógicas e processos discretos. Equivalente inglês: PLC (*Programmable Logic Controller*).

**Cloud SCADA**  
Arquitetura em que o software SCADA é hospedado em infraestrutura de nuvem (AWS, Azure, GCP) em vez de servidores físicos na planta.

**CoAP** (*Constrained Application Protocol*)  
Protocolo leve para dispositivos IoT com recursos limitados, similar ao HTTP mas baseado em UDP. Ideal para sensores com baixa energia.

**Compressão por exceção (swinging door)**  
Estratégia de historização que só grava um novo ponto quando o valor se afasta do último gravado mais que uma tolerância definida. A tolerância é o erro máximo da série reconstruída, e o descarte é irreversível.

---

## D

**Contêiner**  
Forma de empacotar uma aplicação com suas dependências em uma imagem versionada, executável de forma isolada — usada na borda para atualizar aquisição, regras e modelos sem trocar o sistema do gateway.

**Dashboard**  
Painel que reúne indicadores, tendências, estados e alarmes para apoiar decisão. Sem contexto (faixa normal, limite e período) o valor exibido não informa.

**DCS** (*Distributed Control System* — Sistema de Controle Distribuído*)  
Sistema de controle para processos contínuos de grande escala, com controle distribuído em múltiplos controladores de campo e banco de dados centralizado.

**Deadband (faixa morta)**  
Diferença necessária entre o valor de disparo e o de limpeza de um alarme, evitando que ele oscile em torno do limite.

**Deriva (drift)**  
Perda de validade de um modelo ou de um baseline em produção, causada por mudança do processo, do sensor ou da relação entre as variáveis. Silenciosa: o sistema continua respondendo, com confiança, errado.

**Digital Twin (Gêmeo Digital)**  
Representação virtual dinâmica de um ativo físico, processo ou sistema que sincroniza em tempo real com seu equivalente real, permitindo simulação e otimização.

**DMZ Industrial**  
*Demilitarized Zone* — zona de rede intermediária entre a rede corporativa (TI) e a rede industrial (OT), contendo sistemas que precisam trocar dados com ambos os lados (ex.: historiador, servidor web).

**DNP3** (*Distributed Network Protocol 3*)  
Protocolo de comunicação para sistemas SCADA de infraestrutura crítica (energia, água, óleo e gás). Suporta reporte espontâneo e timestamping de eventos.

**DRP** (*Disaster Recovery Plan*)  
Plano de recuperação de desastres — conjunto de procedimentos para restaurar sistemas críticos após falha grave.

---

## E

**Edge Computing (Computação na Borda)**  
Processamento de dados realizado próximo à fonte — no próprio dispositivo ou em um gateway de campo — em vez de na nuvem central.

**EEMUA 191**  
Guia de engenharia da EEMUA para projeto, gestão e contratação de sistemas de alarme; 3ª edição, 2013. É guia, não norma, e é referência usual de valores de desempenho.

**Escalonamento (de faixa)**  
Conversão de uma leitura bruta (contagem do conversor A/D) para a unidade de engenharia do instrumento, por regra de três entre os extremos da faixa.

**Espaço de endereços (address space)**  
No OPC UA, a estrutura de nós e referências que o servidor expõe e que o cliente descobre com `Browse` — diferente do mapa fixo de registradores de um protocolo clássico.

**Ergonomia**  
Conjunto de disciplinas que estuda a organização do trabalho na interação entre seres humanos e máquinas. Aplicada à IHM, busca reduzir sobrecarga, monotonia, cansaço e excesso de informação.

**ERP** (*Enterprise Resource Planning* — Planejamento de Recursos Empresariais*)  
Sistema de gestão integrada de negócios: finanças, RH, logística, vendas. Integra-se ao MES via ISA-95.

**Estado do equipamento**  
Condição qualitativa de um ativo (parado, partindo, operando, parando, em falha), modelada explicitamente em vez de deduzida na tela a partir de tags discretos.

**EtherNet/IP**  
Protocolo industrial Ethernet baseado no CIP (*Common Industrial Protocol*), desenvolvido pela ODVA e amplamente usado no ecossistema Rockwell/Allen-Bradley.

**Evento**  
Ocorrência com importância para o operador que **não** exige ação corretiva (partida de equipamento, troca de turno, janela aberta). Distingue-se do alarme, que exige intervenção.

**Exatidão**  
Grau de proximidade entre o valor medido e o verdadeiro. É definida pelo transmissor e pela instalação — não pela resolução do conversor A/D, que apenas determina o tamanho do degrau.

---

## F

**Failover**  
Comutação automática de um sistema primário para um backup em caso de falha, sem intervenção humana.

**FFT** (*Fast Fourier Transform*)  
Algoritmo de transformada de Fourier para converter um sinal no domínio do tempo para o domínio da frequência — essencial para análise de vibração em manutenção preditiva.

**Fieldbus**  
Barramento digital de comunicação para interligar sensores, atuadores e controladores no nível de campo. Exemplos: Profibus, Foundation Fieldbus, DeviceNet, AS-i.

**Fog Computing**  
Camada de computação intermediária entre o edge (campo) e a nuvem — geralmente um servidor local na planta ou subestação que agrega e pré-processa dados.

**Foundation Fieldbus (FF)**  
Protocolo de fieldbus digital para instrumentação de processo contínuo (petroquímica, refino), com capacidade de executar blocos de função (controle) no próprio instrumento.

---

## G

**Gateway de Protocolo**  
Dispositivo ou software que converte entre diferentes protocolos de comunicação (ex.: Modbus RTU → OPC UA).

**Gateway de borda**  
Equipamento que materializa a borda de campo: conversa com o processo pela face sul (Modbus, OPC UA, DNP3), normaliza e publica pela face norte (MQTT, REST, Sparkplug B), com fila local para sobreviver à queda do enlace.

**Grafana**  
Plataforma de visualização e monitoramento que consulta fontes externas (séries temporais, bancos SQL, Prometheus). Não armazena o dado de processo e não é sistema de comando.

---

## H

**Hierarquia de navegação**  
Organização das telas de um supervisório do geral para o particular, com barra de navegação fixa, navegação horizontal pelo fluxo do processo e retorno sempre disponível.

**HART** (*Highway Addressable Remote Transducer*)  
Protocolo que superpõe comunicação digital (FSK — Frequency Shift Keying) sobre o sinal analógico 4-20 mA, permitindo configuração e diagnóstico remoto de instrumentos.

**Historiador (historian)**  
Sistema que armazena séries temporais de processo, com compressão por exceção e consulta por intervalo. Distingue-se do histórico de eventos, que registra ocorrências com estado, prioridade e reconhecimento.

**HMI** (*Human-Machine Interface* — Interface Homem-Máquina*)  
Dispositivo ou software que apresenta o estado do processo ao operador e permite intervenções. Pode ser local (painel touchscreen) ou centralizado (estação SCADA).

**HA** (*High Availability* — Alta Disponibilidade*)  
Arquitetura de sistema projetada para minimizar o tempo de inatividade, tipicamente com redundância ativa/passiva ou ativa/ativa.

---

## I

**IEC 61131-3**  
Norma internacional que define cinco linguagens de programação para CLPs: Ladder (LD), Blocos de Função (FBD), Texto Estruturado (ST), Lista de Instruções (IL) e Diagrama de Função Sequencial (SFC).

**IEC 62443**  
Família de normas internacionais para cibersegurança em sistemas de automação e controle industrial (IACS).

**IEC 62682**  
Norma internacional de gerenciamento de alarmes para indústrias de processo, alinhada à ISA-18.2; edição vigente de 2022, que substitui a de 2014.

**IIoT** (*Industrial Internet of Things* — Internet Industrial das Coisas*)  
Aplicação do paradigma IoT ao ambiente industrial, com requisitos rigorosos de confiabilidade, latência e segurança.

**InfluxDB**  
Banco de dados de séries temporais muito usado com o Grafana. O dado medido entra como *field* e o ativo como *tag* — inverter isso destrói o desempenho.

**ISA-18.2**  
Norma ISA para gerenciamento de sistemas de alarmes em indústrias de processo; edição vigente de 2016 (a primeira é de 2009).

**ISA-88**  
Norma ISA para controle de processos em batelada (*batch control*): define modelos de receita, equipamentos e fases de processo.

**ISA-95**  
Norma ISA para integração entre sistemas de controle industrial e sistemas corporativos (MES e ERP).

---

## J–L

**Jump Server (Bastion Host)**  
Servidor intermediário através do qual todos os acessos remotos à rede OT devem passar — nunca acesso direto aos CLPs/SCADA.

**KPI** (*Key Performance Indicator*)  
Indicador-chave de desempenho. Em dashboard industrial, exige fórmula e período explícitos — caso contrário vira número decorativo.

**Ladder (LD)**  
Linguagem de programação de CLP que representa a lógica de controle em forma de diagrama elétrico com contatos e bobinas. É a linguagem mais utilizada na indústria.

**LWT** (*Last Will and Testament*)  
Mecanismo MQTT em que o broker publica automaticamente uma mensagem predefinida quando um cliente desconecta inesperadamente — usado para detecção de falha de dispositivos IIoT.

---

## M

**Máquina de estados**  
Modelo que descreve os estados possíveis de um equipamento ou de um procedimento e as transições permitidas entre eles, com o evento que provoca cada transição.

**Mapa de memória (tabela de alocação)**  
Documento que relaciona cada tagname do supervisório ao endereço real do hardware de aquisição/controle e ao driver de comunicação responsável pela leitura.

**Mapa de memória (tabela de alocação)**  
Documento que relaciona cada tagname do supervisório ao endereço real do hardware de aquisição/controle e ao driver de comunicação responsável pela leitura.

**Manutenção preditiva**  
Nível de manutenção em que a intervenção é programada a partir da projeção de falha em janela útil. Exige histórico longo com eventos rotulados; a baseada em condição registra o desvio e o limite que o caracteriza.

**Média móvel**  
Filtro digital que suaviza o ruído calculando a média das *n* últimas amostras; reduz o ruído na proporção da raiz quadrada de *n*, ao custo de atrasar a resposta do sinal.

**MES** (*Manufacturing Execution System* — Sistema de Execução da Manufatura*)  
Sistema que conecta o chão de fábrica ao ERP: rastreabilidade de lotes, qualidade, sequenciamento de ordens, OEE.

**MFA** (*Multi-Factor Authentication*)  
Autenticação multifator — exige dois ou mais fatores de verificação (senha + token + biometria) para acesso a sistemas críticos.

**Modbus**  
Protocolo de comunicação serial criado pela Modicon em 1979. Disponível nas variantes RTU (serial), ASCII e TCP/IP (Ethernet). O mais difundido na indústria.

**MPC** (*Model Predictive Control*)  
Estratégia de controle avançado que utiliza um modelo matemático do processo para prever comportamento futuro e calcular a ação de controle ótima considerando restrições.

**MTU** (*Master Terminal Unit*)  
Servidor central de um sistema SCADA responsável pelo polling das RTUs, banco de dados em tempo real, processamento de alarmes e interface com os clientes HMI.

**MQTT** (*Message Queuing Telemetry Transport*)  
Protocolo leve de mensageria baseado em publicação/assinatura (pub/sub), amplamente utilizado em IIoT. Opera sobre TCP/IP na porta 1883 (ou 8883 com TLS).

---

## N

**NAMUR NA 102**  
Recomendação da NAMUR (2003) para gerenciamento de alarmes na indústria química e farmacêutica; referência histórica que influenciou ISA-18.2 e IEC 62682.

**Node-RED**  
Plataforma open-source de programação visual *flow-based* para integração de dispositivos, APIs e serviços. Mantida pela OpenJS Foundation.

**NTP** (*Network Time Protocol*)  
Protocolo de sincronização de relógios em rede, com precisão típica de milissegundos. Pré-requisito para comparar carimbos de tempo entre controlador, supervisório e historian.

---

## O

**OEE** (*Overall Equipment Effectiveness*)  
Indicador composto de eficiência global de equipamentos = Disponibilidade × Desempenho × Qualidade. Padrão SEMI E10.

**OpEx** (*Operational Expenditure*)  
Despesas operacionais recorrentes — energia, manutenção, assinaturas de software, salários.

**OPC** (*OLE for Process Control*)  
Padrão de interoperabilidade entre softwares SCADA e CLPs no ambiente Windows, baseado em COM/DCOM. Predecessor do OPC UA.

**OPC UA** (*OPC Unified Architecture*)  
Versão moderna e plataforma-independente do OPC: segurança nativa (TLS), modelo de informação orientado a objetos, suporte a Linux e embarcados. Porta padrão: 4840.

**OT** (*Operational Technology*)  
Hardware e software que detecta ou causa mudanças por meio do monitoramento e/ou controle direto de equipamentos físicos, processos e eventos industriais. Contrasta com TI (*Information Technology*).

---

## P–Q

**PAM** (*Privileged Access Management*)  
Solução de gestão de acessos privilegiados — registra, audita e controla sessões de usuários com permissões elevadas em sistemas críticos.

**PID** (*Proportional-Integral-Derivative*)  
Algoritmo de controle realimentado amplamente utilizado na indústria para manter uma variável de processo no setpoint desejado.

**Polling**  
Método de comunicação em que o mestre (MTU/SCADA) interroga periodicamente cada escravo (RTU/CLP) para coletar dados — contrasta com o reporte espontâneo do DNP3.

**Prioridade de alarme**  
Urgência da resposta do operador, derivada da consequência e do tempo disponível. Não confundir com severidade, que descreve a consequência da condição anormal.

**PROFINET**  
Protocolo Ethernet industrial da Siemens/PI (PROFIBUS & PROFINET International), sucessor do Profibus. Suporta RT (Real-Time) e IRT (Isochronous Real-Time) para motion control.

**Profibus**  
Protocolo de fieldbus serial criado na Alemanha em 1987. Variantes: DP (automação discreta, até 12 Mbps) e PA (instrumentação de processo em zonas de risco).

**Provisionamento (as code)**  
Configuração de dashboards, fontes de dados e alertas por arquivo versionado, em vez de ajustes manuais pela interface — o que dá auditabilidade e repetibilidade.

**PTP** (*Precision Time Protocol*, IEEE 1588)  
Protocolo de sincronização com precisão de sub-microssegundo em rede local, usado quando o carimbo de tempo na origem precisa reconstruir a sequência de eventos.

**Qualidade do dado (StatusCode)**  
Código associado a cada valor lido que informa se a leitura é válida (`Good`), incerta (`Uncertain`) ou inválida (`Bad`). Deve ser exibido na tela em vez de substituído por zero.

**QoS** (*Quality of Service*)  
Nível de garantia de entrega no MQTT: 0 (at-most-once), 1 (at-least-once), 2 (exactly-once).

---

## R

**Racionalização de alarmes**  
Processo de documentar, alarme por alarme, causa, consequência, ação esperada, tempo de resposta e prioridade. Alarme sem ação esperada não foi racionalizado.

**Registrador de primeira falha (RPE)**  
Lógica no controlador que grava o código do primeiro sensor a atuar em um endereço de memória e bloqueia as gravações seguintes, preservando a causa raiz em meio a uma avalanche de eventos.

**Resolução de entrada analógica**  
Menor degrau que o conversor A/D consegue representar, dado pelo número de bits da faixa. Não deve ser confundida com exatidão nem com ruído.

**Retenção (política de)**  
Conjunto de regras que define por quanto tempo cada classe de dado é mantida e com que resolução, prevendo agregação, cópia de segurança e descarte planejado.

**Retenção (política de)**  
Conjunto de regras que define por quanto tempo cada classe de dado é mantida e com que resolução, prevendo agregação, cópia de segurança e descarte planejado.

**Rotulagem**  
Registro da causa e do componente em cada ocorrência de manutenção. É o que transforma o histórico de operação em dado utilizável para aprendizado supervisionado.

**RPC** (*Remote Procedure Call*)  
Chamada de procedimento remoto. Em plataformas IIoT, permite que a plataforma envie comandos ao dispositivo (lado do servidor) ou que o dispositivo solicite algo à plataforma (lado do dispositivo).

**RTDB** (*Real-Time Database*)  
Banco de dados em tempo real — mantido na memória do servidor SCADA com o estado atual de todas as variáveis do sistema.

**RTU** (*Remote Terminal Unit*)  
Dispositivo de campo que coleta dados de sensores, executa lógicas simples e transmite ao servidor SCADA (MTU) via protocolo de comunicação.

**Rule chain (cadeia de regras)**  
No ThingsBoard, sequência visual de nós por onde cada mensagem passa: persistir telemetria, salvar atributos, criar e limpar alarmes, publicar em sistemas externos.

---

## S

**SCADA** (*Supervisory Control and Data Acquisition*)  
Sistema de controle supervisório e aquisição de dados — monitora e controla remotamente processos industriais e infraestruturas críticas a partir de uma central de operações.

**Sensor**  
Dispositivo que mede uma grandeza física do processo (temperatura, pressão, nível, vazão, posição) e a converte em sinal elétrico padronizado (4-20 mA, 0-10 V, pulso, digital).

**Sensor virtual (soft sensor)**  
Modelo que estima em tempo real uma variável medida apenas em laboratório ou por analisador caro, a partir de variáveis medidas continuamente. Precisa declarar a sua região de validade.

**Série temporal**  
Conjunto de medições indexadas no tempo. Exige carimbo de tempo confiável: sem o *timestamp* do dispositivo, dado atrasado é gravado como atual.

**Severidade**  
Consequência da condição anormal se ninguém agir. Dimensão distinta da prioridade, que trata da urgência da resposta.

**SFC** (*Sequential Function Chart*)  
Linguagem de programação de CLP (IEC 61131-3) baseada em estados e transições — ideal para controle de sequências e processos batch.

**Shelving (silenciamento temporário)**  
Ocultação manual de um alarme por prazo definido e com justificativa registrada. Diferente da supressão, que é definida em projeto.

**SIS** (*Safety Instrumented System*)  
Sistema de segurança funcional que monitora condições críticas do processo e executa ações de proteção automática (shutdown) para evitar acidentes. Normatizado pela IEC 61511.

**SL** (*Security Level*)  
Nível de segurança definido pela IEC 62443: SL1 (proteção contra causas não intencionais) a SL4 (proteção contra atores estatais).

**SOE** (*Sequence of Events*)  
Registro de sequência de eventos com carimbo de tempo na origem, com resolução de milissegundo ou melhor. Exige relógios sincronizados (NTP ou PTP) em todos os nós.

**Sparkplug B**  
Especificação sobre MQTT com esquema de dados padronizado para IIoT industrial — define payloads, timestamps, estados de sessão e gerenciamento de ativos.

**StatusCode (OPC UA)**  
Código que acompanha cada valor lido, indicando se a leitura é válida ou se a qualidade está comprometida. Ignorá-lo faz um sensor com defeito aparecer como "valor zero".

**Store and forward**  
Armazenamento local do dado durante a queda do enlace, com reenvio posterior preservando o carimbo de origem. É o que evita buracos na série temporal justamente nos períodos de problema.

**Supressão (suppression)**  
Ocultação temporária de um alarme por projeto, enquanto a causa que o tornaria irrelevante está ativa (por exemplo, durante o enchimento de um tanque).

---

## T

**Tag**  
Identificador único de uma variável de processo em um sistema SCADA ou historiador (ex.: `PI-1001` para pressão no ponto 1001). É o nome pelo qual CLP, supervisório, histórico, relatórios e nuvem se referem ao mesmo dado.

**Tag de I/O (de comunicação)**  
Tagname cujo valor é atualizado pelo servidor de comunicação (*driver*), que lê e escreve a memória do hardware de controle. Exige endereçamento informado no cadastro.

**Tag interno (de memória ou RAM)**  
Tagname cujo valor é atualizado no próprio software de supervisão — cálculos, contadores e estado da aplicação —, sem vínculo de atualização com outro software.

**Taxa de amostragem**  
Intervalo entre duas amostras consecutivas de uma variável. Deve seguir a dinâmica do processo: subamostrar produz uma curva que não corresponde à variação real.

**Taxa de varredura (scan rate)**  
Frequência com que o mestre interroga os escravos em uma comunicação por *polling*; define o atraso máximo entre a mudança no campo e sua chegada ao supervisório.

**Telemetria**  
Série temporal publicada por um dispositivo (temperatura, pressão, vazão): cada valor é um ponto no tempo e o histórico é preservado.

**Tendência real e tendência histórica**  
A real exibe os últimos valores a partir de um vetor em memória, com janela limitada; a histórica recupera valores gravados em disco e responde por qualquer período retido.

**ThingsBoard**  
Plataforma de código aberto para coleta, processamento, visualização e gestão de dados de dispositivos IoT/IIoT, com motor de regras, alarmes e RPC.

**TI** (*Tecnologia da Informação*)  
Sistemas computacionais para gestão de informações empresariais: email, ERP, bancos de dados corporativos. Contrasta com OT.

**TLS** (*Transport Layer Security*)  
Protocolo de criptografia para comunicações seguras em rede — sucessor do SSL. Usado para proteger conexões OPC UA, MQTT e HTTPS.

**TSDB** (*Time Series Database*)  
Banco de dados otimizado para séries temporais: índice temporal nativo, compressão por série, agregação contínua e política de retenção própria.

---

## V–Z

**Unidade de engenharia (EU)**  
Grandeza física em que a variável é apresentada ao operador — graus Celsius, metros cúbicos por hora, percentual —, resultante do escalonamento da faixa bruta do conversor.

**Validação de faixa**  
Tratamento que rejeita leituras fisicamente impossíveis (fora da faixa do sensor) e as marca com qualidade ruim, em vez de apresentá-las como valor válido.

**VPN** (*Virtual Private Network*)  
Rede privada virtual que cria um túnel criptografado sobre a internet pública para comunicação segura entre sites remotos ou usuários e a rede corporativa/industrial.

**WirelessHART**  
Extensão sem fio do protocolo HART, baseada em IEEE 802.15.4 e malha de rádio (*mesh*). Permite adicionar comunicação sem fio a instrumentos de processo industriais.

**Zero Trust**  
Modelo de segurança que pressupõe que nenhuma entidade (usuário, dispositivo ou rede) é confiável por padrão — toda conexão deve ser autenticada e autorizada explicitamente.
