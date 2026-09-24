# handoff.md — como continuar este projeto

Documento de passagem: o que existe, como operar e o que fazer a seguir. Para o estado atual e
pendências detalhadas, ver [`status.md`](./status.md).

## 1. Ponto de partida

Tudo é conduzido pela skill **`apostila-scada-iiot`**
(`.github/skills/apostila-scada-iiot/SKILL.md`). Ela concentra o fluxo editorial, as armadilhas
verificadas do LaTeX e do Mermaid, e os scripts. **Leia a skill antes de mexer em qualquer coisa.**

```text
SKILL.md                      fluxo em 6 fases, regras invioláveis, gate de qualidade
references/estrutura.md       arquitetura-alvo de 22 capítulos, convenções, checklist §23
references/fontes.md          corpus em docs/, conversão, rastreabilidade das fontes
references/figuras.md         extração/reuso de figuras, Mermaid e suas armadilhas
references/alarmes.md         normas de alarmes, ciclo de vida, estrutura do capítulo
references/normas-ciberseguranca.md   como verificar norma + fatos já verificados
references/latex.md           pipeline e armadilhas do LaTeX (ler antes de editar o template)
assets/apostila.tex           master LaTeX (capa, caixas, listagens, numeração)
assets/callouts.lua           filtro Pandoc (caixas, mermaid, Unicode, URLs)
scripts/build-pdf.sh          Markdown -> LaTeX -> PDF, com relatório de problemas
scripts/render-mermaid.sh     diagramas -> PDF
scripts/extrair-fontes.sh     PDFs -> Markdown + inventário de imagens
scripts/verificar-estrutura.py  gate editorial
```

## 2. Ciclo de trabalho

```bash
.github/skills/apostila-scada-iiot/scripts/render-mermaid.sh     # se mexeu em diagrama
.github/skills/apostila-scada-iiot/scripts/build-pdf.sh          # compila e reporta
python3 docs/apostila/rebuild.py                                 # regenera a versão web
python3 .github/skills/apostila-scada-iiot/scripts/verificar-estrutura.py
```

O gate precisa terminar em **0 erros e 0 avisos**, e o build em **0 erros, 0 `Overfull \hbox`
e 0 `Overfull \vbox`**. Ao criar um capítulo, atualize `apostila/indice.md` (é dele que a navegação
do HTML e a ordem do livro saem) e o glossário.

## 3. Convenções que não se inventam

- Título: `# Capítulo N – Título`; seções `## N.M`; subseções `### N.M.K`.
- Quadros de destaque com **exatamente quatro** emojis: 📌 Nota, ⚠️ Atenção, 💡 Dica, 🖼️ Figura.
  O `rebuild.py` e o filtro LaTeX classificam as caixas por eles.
- Tabela legendada como `**Tabela N.M – Título**` em linha própria, antes da tabela.
- Numeração manual (`Figura N.M`, `Tabela N.M`) precisa ser sequencial dentro do capítulo: o
  LaTeX renumera e o gate acusa buraco.
- Mínimos por capítulo: 3 figuras, 2 diagramas, 1 tabela comparativa, 1 estudo de caso,
  2 quadros de destaque, 5–10 questões, seção de referências. (Todos os 14 capítulos já têm
  estudo de caso; a **atividade prática** existe só nos capítulos 10 a 13.)
- Toda figura leva `Fonte:`. Toda norma citada exige edição verificada.
- A linha `> **Fonte:**` é escrita logo depois da figura. No **PDF** ela é integrada à legenda
  (ver a armadilha correspondente na seção 4); no **HTML** continua como quadro separado.
- Versionamento (`.gitignore`): entram **`apostila/`, `figuras/*.mmd`, `figuras/*.png`,
  `.github/skills/` e os `.md` da raiz**; ficam de fora **`latex/`, `figuras/*.pdf`,
  `docs/fontes/` e o HTML gerado**, todos reproduzíveis pelos scripts. Os PDFs de origem em
  `docs/` também ficam de fora, por incluírem material de terceiros (ISA) sob licença
  restritiva — comente o bloco 5 do `.gitignore` se o repositório for privado.

## 4. Armadilhas já mapeadas (não redescobrir)

| Área | Armadilha | Onde está documentado |
|---|---|---|
| LaTeX | `latexmk` ausente; `siunitx` ausente; erros engolidos por `-file-line-error`; log binário que zera `grep` | `references/latex.md` |
| LaTeX | master próprio exige `\tightlist`, `\passthrough`, `calc`, `\tcbuselibrary{breakable}`, `xurl` | `references/latex.md` |
| LaTeX | título de capítulo e numeração de seção duplicados se os prefixos do Markdown não forem removidos | `scripts/build-pdf.sh` (etapa 2) |
| Mermaid | parênteses em rótulo de nó de `flowchart` exigem aspas; ids reservados (`OPT`, `LOOP`…) quebram o parse | `references/figuras.md` |
| Mermaid | proporção > 3,5:1 deixa o texto ilegível (o limite de 600 pt do `mmdc` reduz a fonte junto) | `references/figuras.md` |
| Mermaid | `flowchart` com fan-out de três colunas (evento → 3 proveniências → script) sai 4,1:1 e o script acusa "largo demais": trocar por cadeia vertical de decisão | `references/figuras.md` |
| Pandoc | dentro de **um** filtro os inlines são processados antes do bloco: caixas de destaque precisam de dois filtros | `assets/callouts.lua` |
| Figuras | imagem sem atributo de largura estoura a mancha (~700 pt) — resolvido com `\setkeys{Gin}{width,height,keepaspectratio}` | `assets/apostila.tex` |
| Figuras | legenda duplica ("Figura 4.1: Figura 4.1 – …") se o LaTeX também numerar: a apostila numera à mão e o rótulo automático está desligado | `assets/apostila.tex` |
| Figuras | Lista de Figuras imprime o número automático **antes** do rótulo manual ("4.2 Figura 4.3 – …"): `listformat=empty` desliga | `assets/apostila.tex` |
| Figuras | float de figura logo depois de `longtable` transborda a página (`Overfull \vbox` de 261 pt, imagem cortada, sem texto fora da mancha): `figure` redefinido como **não flutuante** e dentro de `minipage` | `assets/apostila.tex` |
| Figuras | caixa "Fonte" sozinha na página anterior: o `callouts.lua` funde figura + `> **Fonte:**` numa legenda só, no PDF | `assets/callouts.lua`, `references/latex.md` |
| Lua | `pandoc.Caption()` não existe no pandoc 3.1: alterar `el.caption.long`/`.short` no lugar | `assets/callouts.lua` |
| Lua | `Blocks` no **mesmo** filtro roda depois dos handlers de bloco (a `BlockQuote` já virou `RawBlock`); a fusão figura+fonte precisa de filtro próprio, antes | `assets/callouts.lua` |
| Conversão | tabela convertida sai colapsada — conferir sempre na página do PDF | `references/fontes.md` |

## 5. Próximos passos sugeridos (em ordem de retorno)

1. **Continuar a extração de figuras** para as 37 posições restantes (cobertura atual: 24 reais).
   O caminho já está provado: `pdfimages -list` para achar as páginas → `pdfimages -png -f P -l P` →
   conferir qualidade numa folha de contato (`montage` ou uma montagem simples com PIL) → **conferir
   a legenda na página do PDF** (`pdftotext -layout -f P -l P`) para não batizar a figura errada →
   inserir como `![Figura N.M – Título](../figuras/nome.png)` com a linha `> **Fonte:**` logo
   depois. Prioridade: capítulos 6, 8 e 9 (15 placeholders) e 1 e 2 (9 placeholders). Reutilizar
   apenas material do próprio curso; material ISA fica como direção de arte até ser redesenhado.

   **Mapa já levantado nesta rodada** (não repetir o garimpo):

   | Fonte | Páginas com figura aproveitável | Serve para |
   |---|---|---|
   | `Sistemas Supervisórios — parte 1` | p. 5 (pirâmide da automação, níveis 0–5) | Figura 2.1 |
   | `Sistemas Supervisórios — parte 1` | p. 8–14 (arquiteturas SCADA níveis 1/2/3) | Figuras 2.3/2.4 |
   | `Sistemas Supervisórios — parte 2` | p. 2 (telas de dois supervisórios), p. 7 e 9 (sinótico × CLP), p. 10 (mapa de memória) | cap. 3 e 14 (14 já usa a p. 10 como tabela) |
   | `IIoT e suas Tecnologias Aderentes` | p. 3 (as 4 revoluções industriais), p. 10–12 (comunicação de dados, LoRaWAN), p. 16 (publish-subscribe MQTT) | Figuras 1.2, 6.x e 5.5 |
   | `Livro SCADA` | Fig. 4 (p. 24), 14 (p. 35), 21 (p. 67), 23 (p. 70) — as demais úteis já foram usadas | cap. 4, 11 e 14 |
   | `IoT.pdf` | p. 14–23 (grades de plataformas e diagramas do ThingsBoard) | cap. 12 |

   Esgotadas: as páginas 20–33 do `Livro SCADA` (todas as figuras de arquitetura já estão na
   apostila) e as páginas 89–139 (telas de InTouch/Elipse, que só repetem tutoriais).
2. **Criar os capítulos que faltam**, na ordem de dependência: aquisição e tratamento de dados →
   historiadores e séries temporais → Edge Computing → integração SCADA+CLP+IoT+Cloud → estudos de
   caso → projetos práticos → IA e Digital Twin. (**Tags, variáveis, estados e eventos** saiu nesta
   rodada como capítulo 14.)
3. **Renumerar uma única vez**, quando o conjunto de capítulos estiver completo (ver `status.md`,
   decisão 3). Enquanto isso, a sequência 1–13 é a vigente e o gate confere a numeração interna.
4. **Redesenhar as figuras de HMI/alarmes** dos capítulos 3, 10 e 11 (hierarquia de telas, uso de
   cor, painel de alarmes) em Mermaid ou desenho próprio, no lugar de reproduzir material ISA.
5. **Revisar o `LICENSE.md`** com os autores (o arquivo descreve outra obra).
6. **Avaliar `\printindex`**: hoje comentado porque não há entradas `\index{}`. Se o índice
   remissivo for desejado, marcar os termos-chave com `\index{}` no texto (o `makeindex` já roda
   no `build-pdf.sh`).

## 6. Fontes e rastreabilidade

- Corpus original em `docs/` (11 PDFs, ~498 páginas): *Livro SCADA*, `supervisorio_scada.pdf`,
  `ISA101.pdf`, simpósio ISA-101 Sabesp, boas práticas SCADA/PIMS, `IoT.pdf`, `IIoT...pdf`,
  `Node-Red_InterfaceDeSupervisão.pdf`, partes 1 e 2 de Sistemas Supervisórios, introdução a IoT.
  `IoT.pdf`, `IIoT...pdf` / `.odp`, `Node-Red...pdf` e as duas partes de *Sistemas Supervisórios*
  são de autoria de **W. S. Vianna** (mesmo autor da apostila) — reutilizáveis com crédito, ao
  contrário do material ISA.
- Capítulos 10 a 12 usam também **documentação oficial** (thingsboard.io, grafana.com/docs) e
  **normas** — as edições verificadas estão registradas em `references/normas-ciberseguranca.md`
  e nas referências de cada capítulo.
- Conversões de PDF ficam em `docs/fontes/` (não versionadas como conteúdo final): servem para
  conferência, nunca para copiar tabela.
