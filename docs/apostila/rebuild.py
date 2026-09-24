#!/usr/bin/env python3
"""rebuild.py — regenera docs/apostila/apostila-scada.html a partir de apostila/*.md.

Fonte de verdade: `apostila/` (na raiz do workspace). Não existem mais cópias dos
capítulos aqui em docs/apostila/ — este script lê direto da origem e reescreve o HTML.

Uso:
    python3 docs/apostila/rebuild.py

O CSS/JS (design, Mermaid, highlight.js, scroll-spy) é preservado do HTML existente:
o script troca apenas a navegação lateral, as seções e a capa.
"""
from __future__ import annotations

import html as _h
import re
import sys
from pathlib import Path

try:
    import markdown
except ImportError:  # pragma: no cover
    sys.exit("ERRO: falta o pacote 'markdown' (pip install markdown)")

RAIZ = Path(__file__).resolve().parents[2]
SRC = RAIZ / "apostila"
HTML = Path(__file__).resolve().parent / "apostila-scada.html"

MD_EXT = ["tables", "fenced_code", "attr_list", "toc", "sane_lists"]

# Imagens vivem em figuras/ (raiz do workspace); deste diretório o caminho precisa de
# um nível a mais do que no Markdown, que é escrito relativo a apostila/.
IMG_DE = re.compile(r'src="\.\./figuras/')
IMG_PARA = 'src="../../figuras/'

CSS_IMAGENS = """
/* imagens dos capítulos */
.chapter img { max-width: 100%; height: auto; display: block; margin: 1.2rem auto;
  border-radius: 8px; border: 1px solid #2a3349; background: #fff; }
.chapter p:has(> img) + p { text-align: center; font-size: .9rem; color: #8892a4; }
"""


def md_para_html(texto: str) -> str:
    """Markdown -> HTML, preservando Mermaid, cercas de código e caixas de destaque."""
    mermaid: list[str] = []

    def guarda_mermaid(m: re.Match) -> str:
        mermaid.append(m.group(1).strip())
        return f"MERMAIDPLACEHOLDER{len(mermaid) - 1}ENDMERMAID"

    texto = re.sub(r"```mermaid\n(.*?)```", guarda_mermaid, texto, flags=re.DOTALL)

    codigos: list[str] = []

    def guarda_codigo(m: re.Match) -> str:
        lang = m.group(1) or ""
        classe = f' class="language-{lang}"' if lang else ""
        codigos.append(f"<pre><code{classe}>{_h.escape(m.group(2).strip())}</code></pre>")
        return f"CODEPLACEHOLDER{len(codigos) - 1}ENDCODE"

    texto = re.sub(r"```(\w*)\n(.*?)```", guarda_codigo, texto, flags=re.DOTALL)
    corpo = markdown.markdown(texto, extensions=MD_EXT)
    # as imagens só existem como src="..." depois da conversão
    corpo = IMG_DE.sub(IMG_PARA, corpo)

    for i, bloco in enumerate(codigos):
        corpo = re.sub(rf"<p>\s*CODEPLACEHOLDER{i}ENDCODE\s*</p>", bloco, corpo)
        corpo = corpo.replace(f"CODEPLACEHOLDER{i}ENDCODE", bloco)

    for i, codigo in enumerate(mermaid):
        pre = f'<pre class="mermaid">{_h.escape(codigo)}</pre>'
        corpo = re.sub(rf"<p>\s*<code>\s*MERMAIDPLACEHOLDER{i}ENDMERMAID\s*</code>\s*</p>", pre, corpo)
        corpo = re.sub(rf"<p>\s*MERMAIDPLACEHOLDER{i}ENDMERMAID\s*</p>", pre, corpo)
        corpo = corpo.replace(f"MERMAIDPLACEHOLDER{i}ENDMERMAID", pre)

    def caixa(m: re.Match) -> str:
        interno = re.sub(r"</?p>", "", m.group(1).strip()).strip()
        if "💡" in interno:
            classe = "tip"
        elif "⚠️" in interno:
            classe = "warning"
        elif "🖼️" in interno:
            classe = "figure"
        else:
            classe = "note"
        return f'<div class="callout callout-{classe}">{interno}</div>'

    return re.sub(r"<blockquote>(.*?)</blockquote>", caixa, corpo, flags=re.DOTALL)


def secoes_e_rotulos() -> list[tuple[str, str]]:
    """Lê o sumário de indice.md → [(slug, rótulo de navegação), ...]."""
    indice = (SRC / "indice.md").read_text(encoding="utf-8")
    itens = [("indice", "Apresentação")]
    for num, titulo, arquivo in re.findall(
        r"^\|\s*(\d+)\s*\|\s*\[([^\]]+)\]\(\./([^)]+)\)\s*\|", indice, re.M
    ):
        itens.append((arquivo[:-3], f"Cap. {num} — {titulo}"))
    # demais arquivos que não são capítulo (glossário, referências...)
    for arquivo in sorted(p.name for p in SRC.glob("*.md")):
        if arquivo.startswith(("capitulo-", "indice")):
            continue
        itens.append((arquivo[:-3], arquivo[:-3].capitalize()))
    return itens


def meta(texto: str, campo: str, padrao: str = "") -> str:
    m = re.search(rf"^\*\*{campo}:\*\*\s*(.+?)\s*$", texto, re.M)
    return m.group(1).strip(" —-") if m else padrao


def capa(indice_md: str) -> str:
    titulo = "Sistemas SCADA e Supervisórios Industriais"
    for h1 in re.findall(r"^#\s+(.+)$", indice_md, re.M):
        if "INSTITUTO" not in h1.upper():
            titulo = h1
            break
    versao = meta(indice_md, "Versão", "2.1").split("—")[0].strip()
    autor = meta(indice_md, "Autor", "")
    return (
        '<div class="cover-card">'
        '<div class="institution-badge">INSTITUTO FEDERAL FLUMINENSE<br/>'
        "Curso de Engenharia de Controle e Automação</div>"
        f"<h1>{titulo}</h1>"
        f'<p class="subtitle">Apostila Técnica Ilustrada — {versao}</p>'
        '<p class="version-info">Supervisão industrial, SCADA, HMI, redes e protocolos, IoT/IIoT, '
        "alarmes, dashboards e ThingsBoard.</p><hr/>"
        f'<p class="author-info"><strong>Autor:</strong> {autor}</p></div>'
    )


TEMPLATE_MINIMO = """<!DOCTYPE html>
<html lang="pt-BR"><head><meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>Apostila — Sistemas SCADA e Supervisórios Industriais</title>
<style>
body{margin:0;background:#0f1117;color:#e2e8f0;font:16px/1.65 Inter,system-ui,sans-serif}
nav#sidebar{position:fixed;inset:0 auto 0 0;width:280px;overflow:auto;background:#161b27;
padding:1rem;border-right:1px solid #2a3349}
nav#sidebar a{color:#c7d2e0;text-decoration:none;font-size:.9rem}
nav#sidebar li{margin:.35rem 0}
main#main{margin-left:300px;max-width:900px;padding:2rem 1.5rem}
.chapter{margin-bottom:4rem}
h1,h2,h3{color:#f1f5f9} a{color:#3b8ef3}
table{border-collapse:collapse;width:100%;margin:1rem 0}
th,td{border:1px solid #2a3349;padding:.45rem .6rem;text-align:left;font-size:.92rem}
pre{background:#161b27;padding:.8rem;border-radius:8px;overflow:auto}
.callout{border-left:4px solid #3b8ef3;background:#161b27;padding:.7rem 1rem;margin:1rem 0;
border-radius:0 8px 8px 0}
.callout-warning{border-color:#e05252} .callout-tip{border-color:#3fb950}
.callout-figure{border-color:#a371f7}
""" + CSS_IMAGENS + """
</style>
<script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
</head>
<body>
<nav id="sidebar"><ul id="nav-list"></ul></nav>
<main id="main">
</main>
<script>if(window.mermaid){mermaid.initialize({startOnLoad:true,theme:'dark'});}</script>
</body></html>
"""


def main() -> int:
    if not (SRC / "indice.md").exists():
        print(f"ERRO: não achei {SRC / 'indice.md'}", file=sys.stderr)
        return 1

    if HTML.exists():
        modelo = HTML.read_text(encoding="utf-8")
        if '<nav id="sidebar">' not in modelo or "</main>" not in modelo:
            print("ERRO: não consegui reaproveitar o CSS/JS do HTML existente", file=sys.stderr)
            return 1
        cabeca, resto = modelo.split('<nav id="sidebar">', 1)
        _, cauda = resto.split("</main>", 1)
        if "/* imagens dos capítulos */" not in cabeca:
            cabeca += f"<style>{CSS_IMAGENS}</style>\n"
    else:
        print("AVISO: HTML inexistente — gerando com o template mínimo embutido")
        cabeca = TEMPLATE_MINIMO.split('<nav id="sidebar">', 1)[0]
        cauda = TEMPLATE_MINIMO.split("</main>", 1)[1]

    indice_md = (SRC / "indice.md").read_text(encoding="utf-8")
    versao = meta(indice_md, "Versão", "2.1").split("—")[0].strip()

    itens = secoes_e_rotulos()
    nav = [
        '<nav id="sidebar">',
        '  <div id="sidebar-header">',
        '    <div class="logo-badge">⚙️ Apostila Técnica</div>',
        "    <h2>Sistemas SCADA &amp; Supervisórios Industriais</h2>",
        f"    <p>Versão {versao} — IIoT / Alarmes / Dashboards</p>",
        "  </div>",
        '  <ul id="nav-list">',
    ]
    for slug, rotulo in itens:
        nav.append(f'<li><a href="#{slug}" class="nav-link">{_h.escape(rotulo)}</a></li>')
    nav += ["  </ul>", "</nav>", '<main id="main">']

    secoes: list[str] = []
    for slug, _ in itens:
        arquivo = SRC / f"{slug}.md"
        if not arquivo.exists():
            print(f"AVISO: {arquivo.name} não existe — seção ignorada")
            continue
        conteudo = md_para_html(arquivo.read_text(encoding="utf-8"))
        if slug == "indice":
            conteudo = re.sub(r"<h1[^>]*>.*?</h1>", capa(indice_md), conteudo, count=1)
        secoes.append(f'<section id="{slug}" class="chapter">\n{conteudo}\n</section>')

    saida = "\n".join([cabeca, *nav, *secoes, "</main>", cauda.lstrip("\n")])
    HTML.write_text(saida, encoding="utf-8")

    mermaid = sum(1 for s in secoes if 'class="mermaid"' in s)
    print(f"OK: {HTML.relative_to(RAIZ)} regenerado — {len(secoes)} seções, "
          f"{saida.count('class=\"mermaid\"')} diagramas Mermaid, "
          f"{saida.count('callout callout-')} quadros de destaque, "
          f"{saida.count('<img ')} figuras")
    return 0


if __name__ == "__main__":
    sys.exit(main())
