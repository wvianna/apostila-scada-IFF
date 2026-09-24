#!/usr/bin/env bash
# build-pdf.sh — Markdown (apostila/) -> LaTeX (latex/) -> PDF, com relatório de problemas.
#
#   .github/skills/apostila-scada-iiot/scripts/build-pdf.sh
#
# Pipeline: render-mermaid -> pandoc (capítulo a capítulo) -> pdflatex x3 + makeindex.
# NÃO usa latexmk: não está instalado neste sistema (usa-se pdflatex direto).
# Saída final: latex/apostila.pdf
set -euo pipefail

WS="$PWD"
SK="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$WS/apostila"
OUT="$WS/latex"

[ -d "$SRC" ] || { echo "ERRO: rode da raiz do workspace (apostila/ não encontrado em $WS)" >&2; exit 1; }
command -v pdflatex >/dev/null || { echo "ERRO: pdflatex ausente" >&2; exit 1; }
command -v pandoc   >/dev/null || { echo "ERRO: pandoc ausente"   >&2; exit 1; }

mkdir -p "$OUT/capitulos" "$OUT/apendices" "$OUT/build"
cp "$SK/assets/apostila.tex"  "$OUT/apostila.tex"
cp "$SK/assets/callouts.lua"  "$OUT/callouts.lua"

# 1. diagramas Mermaid -> figuras/*.pdf
"$SK/scripts/render-mermaid.sh" || echo "AVISO: render-mermaid terminou com erro; seguindo com o que existir"

# autolink_bare_uris: URL em texto puro vira \url{...} — com xurl no preâmbulo, quebra na linha
# (sem isso, as referências estouram a mancha com Overfull \hbox silencioso).
OPTS=(-f markdown+pipe_tables+raw_tex+smart+autolink_bare_uris -t latex
      --top-level-division=chapter --listings --wrap=preserve
      --lua-filter="$OUT/callouts.lua")

# 2. capítulos + manifest
#    O H1 do Markdown é "# Capítulo N – Título", mas o LaTeX já imprime "Capítulo N":
#    sem tirar o prefixo, o título sai duplicado ("Capítulo 1 / Capítulo 1 – ...").
manifest="$OUT/manifest.tex"
: > "$manifest"
n=0
for md in "$SRC"/capitulo-*.md; do
  [ -e "$md" ] || continue
  base="$(basename "$md" .md)"
  # O Markdown traz a numeração escrita à mão ("# Capítulo 1 – ...", "## 1.1 ..."):
  # o LaTeX numera sozinho, então o prefixo precisa sair no caminho para o .tex —
  # senão sai "2.2 1.1 O que é Automação Industrial?". O Markdown original fica intacto
  # (útil para quem lê o .md no GitHub).
  python3 - "$md" "$OUT/build/$base.md" <<'PY'
import re, sys
src, dst = sys.argv[1], sys.argv[2]
linhas = open(src, encoding="utf-8").read().splitlines(True)
for i, l in enumerate(linhas):
    if l.startswith("# "):
        linhas[i] = re.sub(r"^#\s+Cap[íi]tulo\s+\d+\s*[–—-]+\s*", "# ", l)
        break
saida = []
for l in linhas:
    # "Objetivos de Aprendizagem" não é seção numerada no Markdown: sem isso o LaTeX
    # a numera como N.1 e desloca todas as outras em relação ao .md.
    if re.match(r"^##\s+Objetivos de Aprendizagem\s*$", l):
        saida.append("```{=latex}\n\\section*{Objetivos de Aprendizagem}\n```\n")
        continue
    m = re.match(r"^(#{2,5})\s+\d+(?:\.\d+)*\s+(\S.*)$", l)
    saida.append(f"{m.group(1)} {m.group(2).rstrip()}\n" if m else l)
open(dst, "w", encoding="utf-8").write("".join(saida))
PY
  pandoc "$OUT/build/$base.md" "${OPTS[@]}" -o "$OUT/capitulos/$base.tex"
  printf '\\chapterfile{capitulos/%s}\n' "$base" >> "$manifest"
  n=$((n + 1))
done
echo "Capítulos convertidos: $n"

# 3. apresentação (a seção "## Apresentação" de indice.md; o sumário é gerado pelo LaTeX)
#    Fica SEM número de capítulo (\chapter*), senão a Apresentação vira "Capítulo 1"
#    e todos os capítulos ficam deslocados em relação às figuras (Figura N.M).
if [ -f "$SRC/indice.md" ]; then
  python3 - "$SRC/indice.md" "$OUT/build/frontmatter.md" <<'PY'
import re, sys
src, dst = sys.argv[1], sys.argv[2]
txt = open(src, encoding="utf-8").read()
m = re.search(r'^##\s+Apresenta[çc][ãa]o\s*$', txt, re.M)
corpo = txt[m.end():] if m else txt
corpo = re.split(r'^##\s+', corpo, flags=re.M)[0]
# sem H1: o cabeçalho \chapter* é escrito aqui
open(dst, "w", encoding="utf-8").write(corpo.strip() + "\n")
PY
  pandoc "$OUT/build/frontmatter.md" -f markdown+pipe_tables+smart+autolink_bare_uris -t latex \
         --top-level-division=section --listings --wrap=preserve \
         --lua-filter="$OUT/callouts.lua" -o "$OUT/build/frontmatter.tex"
  { printf '\\chapter*{Apresentação}\n'
    printf '\\addcontentsline{toc}{chapter}{Apresentação}\n'
    printf '\\markboth{Apresentação}{Apresentação}\n'
    cat "$OUT/build/frontmatter.tex"; } > "$OUT/frontmatter.tex"
fi

# 4. glossário como apêndice
if [ -f "$SRC/glossario.md" ]; then
  pandoc "$SRC/glossario.md" "${OPTS[@]}" -o "$OUT/apendices/glossario.tex"
fi

# 5. referências (opcional: apostila/referencias.md)
if [ -f "$SRC/referencias.md" ]; then
  pandoc "$SRC/referencias.md" -f markdown+pipe_tables+smart+autolink_bare_uris -t latex \
         --top-level-division=section --listings --wrap=preserve \
         --lua-filter="$OUT/callouts.lua" -o "$OUT/referencias.tex"
  echo "referencias.tex gerado a partir de apostila/referencias.md"
fi

# 6. compilação: pdflatex x3 (referências cruzadas e sumário) + makeindex
cd "$OUT"
mkdir -p build
pass=1
while [ "$pass" -le 3 ]; do
  pdflatex -interaction=nonstopmode -file-line-error -output-directory=build \
           apostila.tex > "build/pass$pass.log" 2>&1 || true
  if [ "$pass" -eq 1 ] && [ -f build/apostila.idx ]; then
    makeindex -o build/apostila.ind build/apostila.idx > /dev/null 2>&1 || true
  fi
  pass=$((pass + 1))
done

if [ -f build/apostila.pdf ]; then
  cp build/apostila.pdf apostila.pdf
else
  echo "ERRO: o PDF não foi gerado. Log: $OUT/build/pass3.log" >&2
  tail -n 40 build/pass3.log >&2
  exit 1
fi

# 7. relatório
# ATENÇÃO 1: com -file-line-error os erros saem como "arquivo.tex:linha: msg", NÃO como "! msg".
#   Contar só "^! " subestima (já deu 0 erros com 23 erros reais neste projeto).
# ATENÇÃO 2: o log pode conter byte não imprimível (listagens) — sem 'grep -a' o grep
#   responde "arquivo binário coincide com o padrão" e o relatório sai zerado.
log=build/pass3.log
erros="$(grep -a -E '^! |\.tex:[0-9]+: ' "$log" | grep -v '^!  *$' || true)"
n_erros="$(printf '%s' "$erros" | grep -a -c . || true)"
vbox="$(grep -a -c 'Overfull .vbox' "$log" || true)"
hbox="$(grep -a -c 'Overfull .hbox' "$log" || true)"
align="$(grep -a -c 'Overfull .hbox.*in alignment' "$log" || true)"
md_mermaid="$(grep -h -c '^```mermaid' "$SRC"/*.md 2>/dev/null | paste -sd+ | bc 2>/dev/null || echo '?')"
figs_pdf="$(ls -1 "$WS"/figuras/*.pdf 2>/dev/null | wc -l)"

paginas="$(pdfinfo apostila.pdf 2>/dev/null | awk '/^Pages/{print $2}')"
echo
echo "PDF:            $OUT/apostila.pdf (${paginas:-?} páginas)"
echo "Capítulos:      $n"
echo "Diagramas Mermaid: $md_mermaid (renderizados: $figs_pdf)"
echo "Erros LaTeX:    $n_erros"
echo "Overfull hbox:  $hbox (em alignment: $align)   <-- alignment = tabela estourando; ver \\tabcolsep"
echo "Overfull vbox:  $vbox   <-- precisa ser 0 (figura mais alta que a página)"
if [ -n "$erros" ]; then
  echo
  echo "--- primeiros erros ---"
  printf '%s\n' "$erros" | head -n 25
fi

if [ "$n_erros" != "0" ] || [ "$vbox" != "0" ]; then
  echo
  echo "Build com pendências. Ver references/latex.md antes de publicar."
  exit 1
fi
echo
echo "OK. Conferir visualmente as páginas suspeitas (references/latex.md)."
