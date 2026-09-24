# Normas e cibersegurança industrial

## Procedimento ao citar uma norma (`promptSkill.md` §22)

1. Identificar a norma pedida e o assunto pretendido.
2. Verificar **título oficial** e organismo (ISA, IEC, EEMUA, NAMUR, IEEE, OASIS…).
3. Verificar **edição vigente e ano** (buscar na fonte do organismo antes de escrever).
4. Verificar **status** (vigente, substituída, em revisão, retirada).
5. Verificar **escopo** — o que a norma cobre e o que ela **não** cobre.
6. Confirmar aplicabilidade ao contexto da apostila.
7. Não atribuir requisitos não verificados ("a norma exige…" só com base lida).
8. **Não reproduzir texto protegido**: resumir princípios com palavras próprias.
9. Registrar a referência bibliográfica completa.
10. Se a norma citada no material antigo estiver desatualizada:

```markdown
> 📌 **Referência histórica:** ...
> 📌 **Referência atualmente aplicável:** ...
> 📌 **Motivo da atualização:** ...
```

## Fatos normativos já verificados (2026-09, fonte pública)

Usar como ponto de partida — **reconfirmar por busca na web** antes de publicar, e nunca
apresentar como texto da norma.

- **IEC 61131**: 1ª ed. 1993; parte 3 em 2ª ed. 2003 e 3ª ed. 2013 (POUs orientadas a objetos,
  depreciação da IL); **4ª ed. de maio/2025, vigente** (remove IL). Família até a parte 10
  (10 = XML de intercâmbio, esquemas da PLCopen).
- **IEC 61508** (segurança funcional): 1ª ed. 1998–2000, 2ª ed. 2010. **IEC 61511** para
  indústria de processo.
- **IEC 62443** (joint ISA99 / IEC TC65 WG10, norma horizontal de segurança OT): zonas e
  conduítes, papéis (proprietário do ativo, integrador, fornecedor), *security levels* SL 0–4 e
  níveis de maturidade 1–4. Partes/anos: 62443-3-3:2013, -4-1:2018, -4-2:2019, -3-2:2020,
  -2-1:2024.
- **ISO/IEC 27001:2022** (ed. 3, out/2022, com emenda em 2024) e **NIST CSF 2.0** para a camada
  corporativa/TI.
- **OPC UA**: lançado em 2008 pela OPC Foundation (assinatura, eventos, métodos, modelo de
  informação, PubSub, certificados X.509).
- **MQTT**: padrão OASIS (3.1.1 e 5.0), QoS 0/1/2. **Sparkplug**: especificação 3.0 mantida pela
  Eclipse Foundation.
- Normas de protocolo, quando o tema aparecer: IEC 60870-5-104 (telecontrole), DNP3 (IEEE 1815),
  IEC 61850 (subestações), Modbus (Modbus Organization), EtherNet/IP (ODVA), PROFINET (PI),
  ISA-95/IEC 62264 (integração MES/ERP).

> ⚠️ **Escopos que se confundem:** alarmes de processo → ISA-18.2 / IEC 62682 / EEMUA 191 /
> NAMUR NA 102 (ver [alarmes.md](./alarmes.md)); **não** usar IEC 60839 (alarme de segurança
> eletrônica/patrimonial) para esses requisitos.

## Cibersegurança — conteúdo obrigatório (§15)

1. **Zonas e conduítes** (IEC 62443): agrupar ativos por função/criticidade e controlar o
   tráfego que cruza fronteiras; o conduíte é o caminho de comunicação entre zonas.
2. **Segmentação** entre rede OT e corporativa; DMZ industrial; regra de fluxo explícita.
3. **Identidade e acesso**: autenticação, autorização por papel, contas individuais (sem conta
   compartilhada), princípio do menor privilégio, revisão periódica de acessos.
4. **Hardening** de estação de supervisão, servidor SCADA, gateway e dispositivos IoT: serviços
   desnecessários desligados, contas padrão removidas, atualização controlada.
5. **Protocolos**: falta de autenticação em protocolos clássicos (Modbus, DNP3, IEC 60870-5-104)
   versus segurança nativa do OPC UA (X.509, assinatura e criptografia) e uso de TLS no MQTT.
6. **Certificados e chaves**: ciclo de vida, revogação, arquivo seguro, não embutir segredo em
   firmware.
7. **VPN, firewalls industriais**, acesso remoto auditado e com duplo fator.
8. **Backups**, restauração testada, gestão de mudanças e de patches com janela de manutenção.
9. **Logs e monitoramento**: trilha de auditoria de comandos, alteração de limites/parâmetros e
   eventos de segurança; detecção de anomalia em rede OT.
10. **Segurança de dispositivos IoT/IIoT**: provisionamento seguro, identidade por dispositivo,
    atualização de firmware, dados em trânsito e em repouso.

## Casos públicos citáveis (sem detalhar exploração)

- **Stuxnet (2010)** — marco do risco em redes industriais.
- **CVE-2021-22681** (Rockwell Logix: exposição de credencial/chave; CVSS 3.1 base 9,8 no NVD,
  crítico, no catálogo KEV da CISA).
- **CVE-2022-1159** (injeção de código via Studio 5000 Logix Designer; 7,2 no NVD e 7,7 no
  ICS-CERT).

Citar o identificador, o produto e o efeito — não escrever receita de ataque.

## Amarração didática

O capítulo de cibersegurança deve conversar com: arquitetura SCADA (pontos de exposição),
protocolos (o que cada um oferece), IoT/IIoT e gateways (superfície de ataque crescente) e
alarmes (integridade da trilha de auditoria). Terminar com a pergunta que o aluno fará:
"por onde começo?" — resposta: inventário de ativos, zonas, regras de fluxo, contas.
