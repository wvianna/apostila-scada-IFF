#!/usr/bin/env bash
# render-mermaid.sh — extrai os blocos ```mermaid de apostila/*.md e renderiza para PDF.
#
#   scripts/render-mermaid.sh              # todos os capítulos
#   scripts/render-mermaid.sh --forcar     # re-renderiza mesmo se o PDF existir
#
# Saídas: figuras/<arquivo>-mK.mmd  e  figuras/<arquivo>-mK.pdf
# O nome tem de casar com o que assets/callouts.lua espera (capitulo-NN-mK.pdf).
# mmdc precisa do Chrome do sistema (o Chromium do Puppeteer não está instalado).
set -euo pipefail

WS="$PWD"
SRC="$WS/apostila"
OUT="$WS/figuras"
[ -d "$SRC" ] || { echo "ERRO: rode da raiz do workspace (apostila/ não encontrado em $WS)" >&2; exit 1; }

command -v mmdc >/dev/null || { echo "ERRO: mmdc ausente (npm i -g @mermaid-js/mermaid-cli)" >&2; exit 1; }
mkdir -p "$OUT"

FORCAR=0
[ "${1:-}" = "--forcar" ] && FORCAR=1

PUPPET="${TMPDIR:-/tmp}/puppeteer-apostila.json"
if [ ! -f "$PUPPET" ]; then
  for chrome in /usr/bin/google-chrome /usr/bin/google-chrome-stable /usr/bin/chromium /usr/bin/chromium-browser; do
    if [ -x "$chrome" ]; then
      printf '{"executablePath":"%s"}\n' "$chrome" > "$PUPPET"
      break
    fi
  done
fi
if [ ! -f "$PUPPET" ]; then
  echo "ERRO: nenhum Chrome/Chromium encontrado para o mmdc" >&2; exit 1
fi

# extrai cada bloco ```mermaid para figuras/<arquivo>-mK.mmd (não editar à mão: é gerado)
for md in "$SRC"/*.md; do
  base="$(basename "$md" .md)"
  awk -v base="$base" -v out="$OUT" '
    /^```mermaid/ { n++; f = sprintf("%s/%s-m%d.mmd", out, base, n); next }
    /^```/        { if (f != "") { close(f); f = "" } ; next }
    f != ""       { print > f }
  ' "$md" || true
done

total=$(ls -1 "$OUT"/*.mmd 2>/dev/null | wc -l)
novos=0; atuais=0; erros=0
for mmd in "$OUT"/*.mmd; do
  [ -e "$mmd" ] || continue
  pdf="${mmd%.mmd}.pdf"
  if [ -f "$pdf" ] && [ "$FORCAR" -eq 0 ] && [ "$pdf" -nt "$mmd" ]; then
    atuais=$((atuais + 1)); continue
  fi
  if ! mmdc -i "$mmd" -o "$pdf" --puppeteerConfigFile "$PUPPET" --pdfFit -q >/dev/null 2>&1; then
    echo "ERRO: falhou ao renderizar $(basename "$mmd")" >&2
    erros=$((erros + 1)); continue
  fi
  novos=$((novos + 1))
  medida="$(pdfinfo "$pdf" 2>/dev/null | awk '/^Page size/{print $3, $5}')"
  set -- $medida
  w="${1:-0}"; h="${2:-0}"
  razao="$(awk -v w="$w" -v h="$h" 'BEGIN{ if (h>0) printf "%.2f", w/h; else print 0 }')"
  # O alerta olha o que realmente degrada a leitura:
  #  - largo demais: o mmdc limita a largura da página a 600 pt e reduz a fonte junto
  #    (acima de ~3,5:1 o texto fica pequeno; acima de ~6:1, ilegível);
  #  - alto demais: a inclusão no LaTeX tem height=0.8\textheight, então não estoura a
  #    página — perde-se tamanho. Abaixo de ~0,30 a fonte fica comprimida demais.
  alerta=""
  awk -v r="$razao" 'BEGIN{ exit (r > 3.5) ? 0 : 1 }' && alerta=" <-- largo demais, o texto vai sair pequeno"
  awk -v r="$razao" 'BEGIN{ exit (r < 0.30) ? 0 : 1 }' && alerta=" <-- alto demais, a fonte fica comprimida"
  printf '   %-28s %sx%s pt (proporção %s)%s\n' "$(basename "$pdf")" "$w" "$h" "$razao" "$alerta"
done

echo
echo "Diagramas: $total   Já atualizados: $atuais   Renderizados agora: $novos   Falhas: $erros"
echo "Fique abaixo de ~3,5:1 de largura (acima disso o texto encolhe). Ver references/figuras.md."
