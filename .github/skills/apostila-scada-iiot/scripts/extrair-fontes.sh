#!/usr/bin/env bash
# extrair-fontes.sh — converte os PDFs de docs/ para Markdown e inventaria as figuras.
#
#   scripts/extrair-fontes.sh                    # todo o corpus (docs/*.pdf, docs/isa101/*.pdf)
#   scripts/extrair-fontes.sh docs/IoT.pdf       # um arquivo
#   scripts/extrair-fontes.sh --forcar docs/IoT.pdf
#
# Saídas: docs/fontes/<slug>.md  e  docs/fontes/_imagens.csv
# Conversão: anydoc (npx, não instala) -> pdftotext -layout (fallback).
# Página sem texto extraível = exit 3 do anydoc; ver references/fontes.md para OCR.
set -euo pipefail

WS="$PWD"
[ -d "$WS/docs" ] || { echo "ERRO: rode da raiz do workspace (docs/ não encontrado em $WS)" >&2; exit 1; }

FORCAR=0
ARGS=()
for a in "$@"; do
  case "$a" in
    --forcar) FORCAR=1 ;;
    *) ARGS+=("$a") ;;
  esac
done

OUT="$WS/docs/fontes"
mkdir -p "$OUT"
INV="$OUT/_imagens.csv"

shopt -s nullglob
if [ ${#ARGS[@]} -eq 0 ]; then
  set -- "$WS"/docs/*.pdf "$WS"/docs/isa101/*.pdf
else
  set -- "${ARGS[@]}"
fi
[ $# -gt 0 ] || { echo "ERRO: nenhum PDF encontrado" >&2; exit 1; }

if [ ! -f "$INV" ]; then
  echo "arquivo,pagina,num,tipo,largura,altura,ppi" > "$INV"
fi

ok=0; falhou=0
for pdf in "$@"; do
  [ -f "$pdf" ] || { echo "-- ignorado (não existe): $pdf" >&2; continue; }
  nome="$(basename "$pdf")"
  slug="$(printf '%s' "${nome%.pdf}" | tr -c '[:alnum:]' '-' | sed 's/-\+/-/g; s/^-//; s/-$//' | tr '[:upper:]' '[:lower:]')"
  md="$OUT/$slug.md"

  echo "== $nome"
  if [ -f "$md" ] && [ "$FORCAR" -eq 0 ]; then
    echo "   já convertido -> $md (use --forcar para refazer)"
  else
    if npx -y @firecrawl/anydoc "$pdf" -o "$md.tmp" >/dev/null 2>&1; then
      mv "$md.tmp" "$md"
      echo "   anydoc -> $md ($(wc -l < "$md") linhas)"
    else
      rc=$?
      rm -f "$md.tmp"
      if command -v pdftotext >/dev/null; then
        pdftotext -layout "$pdf" "$md"
        echo "   AVISO: anydoc falhou (exit $rc); usei pdftotext -layout -> $md"
        echo "          (sem estrutura de títulos; conferir tabelas na página original)"
      else
        echo "   ERRO: conversão falhou (exit $rc) e pdftotext ausente" >&2
        falhou=$((falhou + 1)); continue
      fi
    fi
  fi

  if command -v pdfimages >/dev/null; then
    pdfimages -list "$pdf" 2>/dev/null | tail -n +3 \
      | awk -v f="$nome" 'NF>=13 {printf "%s,%s,%s,%s,%s,%s,%s\n", f, $1, $2, $3, $4, $5, $13}' >> "$INV"
  fi
  ok=$((ok + 1))
done

echo
echo "Convertidos: $ok   Falhas: $falhou"
echo "Inventário de imagens: $INV"
echo "Próximo passo: catalogar e classificar as figuras (references/figuras.md)."
