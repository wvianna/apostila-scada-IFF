# Fontes, conversão e rastreabilidade

## Corpus de origem (`docs/`)

| Arquivo | Páginas | Assunto | Capítulos-alvo |
|---|---|---|---|
| `Livro_SCADA_Versão_para_análise.pdf` | 144 | SCADA completo (fonte principal) | 3, 4, 5, 10, 17, 18 |
| `supervisorio_scada.pdf` | 67 | sistemas supervisórios | 1, 3, 4 |
| `ISA101.pdf` | 64 | HMI: projeto de telas, hierarquia, cor, alarme visual | 3, 11, 17 |
| `ISA-101-III-Simpósio-ISA-São-Paulo-Sabesp-Nov2016.pdf` | 68 | ISA-101 aplicada (Sabesp) | 3, 11, 20 |
| `ISA_boas-praticas_SCADAPIMS-2017.pdf` | 42 | boas práticas SCADA/PIMS | 4, 10, 11 |
| `IoT.pdf` | 34 | IoT: arquitetura, protocolos, aplicações | 9, 14, 15, 16 |
| `Node-Red_InterfaceDeSupervisão.pdf` | 21 | Node-RED como IHM | 12 |
| `IIoT e suas Tecnologias Aderentes.pdf` | 18 | IIoT, tecnologias adjacentes (há também o `.odp`) | 14, 15, 16 |
| `Sistemas Supervisórios ... parte 1.pdf` | 16 | fundamentos de supervisão | 1, 3 |
| `Sistemas Supervisórios ... parte 2.pdf` | 16 | supervisão, continuação | 3, 4 |
| `lopez_research_an_introduction_to_iot_..._portuguese.pdf` | 8 | introdução acadêmica a IoT | 14 |

Temas **sem** cobertura no corpus e que exigem pesquisa externa: ThingsBoard, Grafana,
Edge Computing, séries temporais, ISA-18.2/IEC 62682/EEMUA 191/NAMUR NA 102, IEC 62443.

## Conversão para Markdown

```bash
.github/skills/apostila-scada-iiot/scripts/extrair-fontes.sh          # corpus todo
.github/skills/apostila-scada-iiot/scripts/extrair-fontes.sh arquivo.pdf  # um arquivo
```

Ordem de preferência e saídas: `docs/fontes/<slug>.md` + `docs/fontes/_imagens.csv`.

1. `npx -y @firecrawl/anydoc <pdf> -o <saida.md>` (skill `convert-documents-to-markdown`;
   `npx` disponível, não precisa instalar).
2. Fallback local: `pdftotext -layout <pdf> <saida.md>`.
3. OCR: `ocrmypdf --force-ocr --pages N-M` (ou `qpdf --empty --pages` para isolar intervalos
   limpos) e `pdftoppm -r 600 -gray -png` + `tesseract - --psm 6 -l eng`.
   Não usar `--ocr hosted` sem necessidade real: exige chave e envia o documento a terceiros.

## Armadilhas verificadas na conversão

- **Tabela convertida sai colapsada/fundida.** Nunca copiar tabela do Markdown gerado:
  reescrever a partir da página do PDF (`pdftotext -layout -f P -l P`) ou reler a imagem da página.
- Esquemático (`*.sch.pdf`) convertido perde o posicionamento e vira grade — serve só como
  índice de sinais; valores de componente exigem conferência no PDF original.
- Exit code 3 do `anydoc` = página sem texto extraível **ou** página cujo conteúdo real é
  desenho vetorial (pinout, tabela vetorizada) mesmo tendo camada de texto.
- `ocrmypdf --skip-text` pode reportar "page already has text" e não resolver; usar
  `--force-ocr` apenas nas páginas problemáticas.
- Após converter, conferir: ordem das páginas, títulos, tabelas quebradas, caracteres
  incorretos, fórmulas, siglas, legendas e referências cruzadas (§4 do `promptSkill.md`).

## Rastreabilidade (controle interno)

Cadeia obrigatória para cada trecho reaproveitado:

```text
Capítulo → Seção → Documento de origem → Página → Figura/Tabela
```

Classificar e, quando o leitor precisar saber, declarar no texto com um destes blocos:

```markdown
> 📌 **Material original:** <documento>, p. <N>.
> 📌 **Atualização tecnológica:** <o que mudou e por quê>.
> 📌 **Pesquisa externa:** <fonte>.
```

Regras:

- **Sem origem conhecida, o trecho não é escrito.**
- Não atribuir ao material original nada que veio de pesquisa externa (§21) e vice-versa.
- Não inventar número de página; se a página não foi anotada, omitir a citação em vez de chutar.
- Manter, ao final do capítulo, `## Referências` com a bibliografia efetivamente usada.
