# LaTeX — pipeline e armadilhas verificadas

Compilar **antes** de mexer no template: `scripts/build-pdf.sh`. Depois conferir os avisos que
ele imprime (erros reais, `Overfull \vbox`, figuras e capítulos ausentes).

## Ferramentas (verificado em 2026-09)

| Ferramenta | Status | Nota |
|---|---|---|
| `pdflatex` | OK | TeX Live 2023/Debian, pdfTeX 1.40.25 |
| `xelatex`, `pandoc`, `makeindex` | OK | alternativa e indexação |
| `latexmk` | **AUSENTE** | não usar; rodar `pdflatex` 3× + `makeindex` |
| `mmdc` + `/usr/bin/google-chrome` | OK | Puppeteer Chromium ausente → configurar `executablePath` |
| `pdftotext`, `pdfimages`, `pdfinfo`, `pdftoppm`, `pdfcrop`, `montage`, `gs`, `qpdf`, `ocrmypdf`, `tesseract` | OK | extração, conferência visual, OCR |
| `siunitx` | **AUSENTE** | escrever `24\,V`, `4--20\,mA`; nunca `\SI`/`\qty` |

Pacotes confirmados: `tcolorbox`, `longtable`, `booktabs`, `babel`, `inputenc`, `fontenc`,
`graphicx`, `hyperref`, `listings`, `xcolor`, `titlesec`, `tocloft`, `fancyhdr`, `caption`,
`enumitem`, `makeidx`, `mdframed`, `tikz`, `amsmath`, `amssymb`, `microtype`, `newunicodechar`.

## Fluxo

```bash
.github/skills/apostila-scada-iiot/scripts/build-pdf.sh
```

1. `render-mermaid.sh` gera `figuras/capNN-mK.pdf` (Mermaid também é renderizado no Markdown,
   mas não entra em PDF LaTeX como bloco de código).
2. `pandoc` converte cada `apostila/capitulo-NN.md` → `latex/capitulos/capitulo-NN.tex`
   (`--top-level-division=chapter`, `--listings`, `--wrap=preserve`,
   `--lua-filter=assets/callouts.lua`).
3. O master `latex/apostila.tex` inclui `latex/manifest.tex`, gerado com um `\chapterfile{...}`
   por capítulo existente (`\IfFileExists` avisa em vez de quebrar).
4. `pdflatex` ×3 + `makeindex`; saída `latex/apostila.pdf`.

## Armadilhas (todas verificadas em obra anterior)

- **Erro engolido por `-file-line-error`**: com essa opção o `pdflatex` escreve
  `arquivo.tex:linha: msg` e **não** `! msg`. `grep '^! '` pode dar 0 erros com dezenas de erros
  reais. Padrão correto: `grep -E '^! |\.tex:[0-9]+: '`.
  Sintoma de erro engolido: numeração de figura/tabela pulando (7.3 seguido de 7.5).
- **Log com bytes não imprimíveis**: se houver listagem com caractere estranho, o `grep` responde
  "arquivo binário coincide com o padrão" e o relatório sai zerado sem avisar. Usar `grep -a` em
  todas as leituras de `build/pass*.log` (o `build-pdf.sh` já faz).
- **`Overfull \vbox (... too high)` não conta como erro**: é figura/float mais alto que a página.
  Conferir sempre: `grep -c 'Overfull .vbox' latex/build/pass3.log` deve ser **0**.
- **`\tabcolsep` entra na largura da tabela**: cada coluna `p{x cm}` ocupa `x + 2\tabcolsep`.
  Com o padrão de 6 pt, uma tabela de 14,6 cm em 3 colunas mede ~15,87 cm e transborda a mancha,
  gerando `Overfull \hbox ... in alignment` **silencioso** na contagem de erros. O template já
  define `\setlength{\tabcolsep}{3pt}`; orçamento prático: soma das `p{}` até ~14,6 cm (3 colunas)
  ou ~14,3 cm (4 colunas).
- **`lstlisting` (~70 caracteres por linha)**: acima disso quebra — e quebra em desenho de Ladder
  ou JSON ASCII destrói o alinhamento. Medir no Markdown:
  `awk '/begin\{lstlisting\}/{i=1;next} /end\{lstlisting\}/{i=0} i&&length($0)>70'`.
  (O `verificar-estrutura.py` já avisa, ignorando blocos `mermaid`, que viram imagem.)
- **Acentos dentro de listagem**: `\lstinline`/`lstlisting` com `ã`, `ê` etc. falha com
  `Invalid UTF-8 byte sequence` — o template traz `extendedchars=true` + `literate` para isso.
- **URL em texto puro não quebra linha**: gera `Overfull \hbox` de 5 cm e passa batido.
  O `callouts.lua` converte URL sem esquema (`siemens.com/global/...`) em `\url{...}` e o
  template carrega `xurl`; `\emergencystretch=2em` cobre o resto.
- **`tcolorbox` no topo da página logo após tabela `[H]` sai desenhada acima da folha** (título
  cortado na borda de cima, cabeçalho escondido atrás do fundo; log limpo). Diagnóstico (o
  cabeçalho corrente fica em y≈36 pt neste template):
  `pdftotext -bbox latex/apostila.pdf - | awk -F'"' '/<word / && $4+0 < 25' | wc -l` — deve ser 0.
  Causa: quebra feita pelo `tcolorbox`, compensação negativa de `\topskip`. Correção: frase de
  fecho entre a tabela `[H]` e a caixa, ou `\clearpage`. Encurtar célula só resolve se ela for a
  mais alta da linha. Com tabelas do pandoc (`longtable`, sem `[H]`) o risco é baixo.- **Figura como float depois de `longtable` estoura a página** (verificado 2026-09): todas as
  tabelas do pandoc são `longtable`, e o TeX estima o espaço restante de forma otimista quando o
  float vem imediatamente depois. Sintoma: `Overfull \vbox (261 pt too high) has occurred while
  \output is active` no log, com a figura começando no rodapé e sendo cortada — e **nenhum** texto
  fora da mancha (o `pdftotext -bbox` não acusa; é a imagem que transborda). Passar o
  `\floatplacement` de `htbp` para `tbp` **não** resolve. Solução adotada: `figure` redefinido no
  template como **não flutuante** e envolvido em `minipage` (imagem + legenda num bloco
  indivisível; sem a `minipage` o TeX quebra a página entre as duas). A Lista de Figuras continua
  funcionando com `\captionsetup{type=figure}`.
- **Lista de Figuras com número duplicado**: `labelformat=empty` resolve a legenda impressa, mas o
  LOF continua imprimindo o número automático antes do rótulo manual e os dois divergem
  ("4.2 Figura 4.3 – …"), porque os placeholders não geram entrada no LOF e deslocam a contagem.
  Correção: `\captionsetup[figure]{labelformat=empty,listformat=empty}`.
- **Legenda separada da caixa "Fonte"**: a caixa `tcolorbox` não flutua e ficava sozinha na página
  anterior quando a figura ia para a seguinte (medido: **12 das 20** figuras reais). Correção no
  `callouts.lua` (filtro próprio, que roda **antes** do filtro das caixas): figura + bloco
  `> **Fonte:**` viram uma legenda só — `\caption[curta]{curta. \textbf{Fonte:} …}` —, com o
  Markdown e a versão HTML inalterados. Consequência: no **PDF** a fonte aparece dentro da legenda,
  não em caixa própria.- **`longtable`**: `\caption`/`\label` antes do `\toprule`; cabeçalho repetido com `\endhead`;
  rodapé com `\endfoot`; fechamento com `\endlastfoot`.
- **Unicode**: `inputenc`+`utf8` não aceita setas, emoji nem símbolos matemáticos soltos.
  O `callouts.lua` converte (`→`→`$\rightarrow$`, `≈`, `≤`, `≥`, `×`, `µ`, `Ω`, `°`, `Δ`) e
  remove emoji — emoji nunca chega ao `pdflatex`. Dentro de listagem, o mapa é ASCII (`→`→`->`).
- **`\and` não existe fora de `\author`** — na capa usar `\\` entre autores.
- **Página física do PDF = rótulo impresso + 1** (a capa não é numerada).

## Master próprio × template do pandoc

O `assets/apostila.tex` é um master próprio (o pandoc **não** é chamado com `--standalone`), então
macros que o template padrão do pandoc define precisam existir aqui. Já resolvido no template —
está listado porque é a causa de enxurrada de erros se alguém remover:

| Item | Por que | Sem isso |
|---|---|---|
| `\tightlist` | todo `itemize`/`enumerate` do pandoc | ~770 "Undefined control sequence" |
| `\passthrough` | código inline (`\lstinline`) | idem |
| `calc` | pandoc emite `p{(\columnwidth - 6\tabcolsep) * \real{0.25}}` | "Missing number"/"Illegal unit" em toda tabela |
| `\tcbuselibrary{breakable}` | caixas de destaque | `I do not know the key '/tcb/breakable'` |
| `xurl` | URL longa quebrável | `Overfull \hbox` de vários cm |
| conversão de URL sem esquema em `\url{}` (no `callouts.lua`) | idem, para `siemens.com/...` | idem |
| `\emergencystretch=2em` | parágrafos com termos técnicos longos | `Overfull \hbox` residual |
## Numeração: o Markdown escreve, o LaTeX reescreve

O Markdown traz a numeração à mão (`# Capítulo 3 – …`, `## 3.2 …`, `### 3.2.1 …`) e o LaTeX
numera sozinho. O `build-pdf.sh` remove esses prefixos **no caminho para o `.tex`** (o `.md`
original fica intacto, porque é lido também no GitHub):

- `# Capítulo N – Título` → `# Título` (senão sai "Capítulo 1 / Capítulo 1 – Introdução…");
- `## N.M …` / `### N.M.K …` → sem o número (senão sai "2.2 1.1 O que é…");
- `## Objetivos de Aprendizagem` → `\section*` cru (senão o LaTeX a numera como N.1 e desloca
  todas as outras em relação ao `.md`).

Consequência: `\counterwithin{figure}{chapter}` faz "Figura N.M" do PDF bater com os rótulos
manuais do Markdown **desde que as figuras apareçam na ordem numerada** no capítulo
(é o que o `verificar-estrutura.py` cobra).

Só as figuras **reais** entram na Lista de Figuras — os `🖼️` placeholders são caixas `tcolorbox` e
não têm legenda. Por isso a numeração do LOF é uma contagem à parte e **divergiria** do rótulo
manual; é o `listformat=empty` que evita imprimir esse número automático.

## Lua: ordem dos filtros importa

Dentro de **um** filtro, o pandoc percorre os inlines antes do bloco — o emoji do callout era
removido antes de o `BlockQuote` ser lido, e todas as caixas saíam "Nota". Por isso
`callouts.lua` devolve **dois** filtros: primeiro os blocos (caixas, mermaid), depois a limpeza
de Unicode. Não juntar os dois de novo.

## Editar arquivos do template

`create_file` falha em arquivo existente e `replace_string_in_file` pode reportar sucesso sem
aplicar. Para reescrever um `.tex`/`.lua` inteiro: `rm` e depois `create_file`.

## Verificação visual (obrigatória antes de considerar pronto)

```bash
pdftoppm -f 42 -l 42 -r 100 -png latex/apostila.pdf /tmp/pg     # página suspeita
montage /tmp/pg*.png -tile 4x -geometry +4+4 /tmp/contato.png   # folha de contato
```

Abrir a imagem e olhar. O compilador acusa erro de sintaxe, mas **não** acusa figura ilegível,
tabela transbordando de forma sutil nem caixa desenhada fora da folha.
