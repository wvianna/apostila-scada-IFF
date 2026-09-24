#!/usr/bin/env python3
"""verificar-estrutura.py — gate editorial da apostila (roda da raiz do workspace).

Checa o que o compilador de LaTeX NÃO acusa: mínimos por capítulo, numeração de
figuras/tabelas sem buraco, blocos de código largos demais, emoji fora do padrão,
drift entre apostila/ e docs/apostila/ e capítulos não registrados no sumário/rebuild.py.

    .github/skills/apostila-scada-iiot/scripts/verificar-estrutura.py [--quieto]

Exit code 1 se houver ERRO; 0 se houver apenas avisos.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

RAIZ = Path.cwd()
APOSTILA = RAIZ / "apostila"
COPIA = RAIZ / "docs" / "apostila"

EMOJIS_OK = {"📌", "⚠️", "💡", "🖼️"}
MIN_FIGURAS, MIN_MERMAID, MIN_QUESTOES = 3, 2, 5
LIMITE_LINHA_CODIGO = 70

erros: list[str] = []
avisos: list[str] = []


def erro(msg: str) -> None:
    erros.append(msg)


def aviso(msg: str) -> None:
    avisos.append(msg)


def blocos_codigo(texto: str) -> list[tuple[int, str, list[str]]]:
    """(linha inicial, linguagem, linhas) de cada cerca de código."""
    saida, dentro, inicio, lang, buf = [], False, 0, "", []
    for i, linha in enumerate(texto.splitlines(), 1):
        if linha.startswith("```"):
            if dentro:
                saida.append((inicio, lang, buf))
                dentro, buf = False, []
            else:
                dentro, inicio, lang, buf = True, i, linha[3:].strip(), []
            continue
        if dentro:
            buf.append(linha)
    return saida


def numeracao_sem_buraco(rotulos: list[int], nome: str, arq: str) -> None:
    """A numeração manual (Figura N.M / Tabela N.M) precisa ser 1,2,3... dentro do capítulo.

    Menções repetidas no texto ("a Tabela 3.1 resume...") são descartadas: só a primeira
    ocorrência de cada número conta.
    """
    distintos: list[int] = []
    for n in rotulos:
        if not distintos or distintos[-1] != n:
            distintos.append(n)
    esperado = 1
    for n in distintos:
        if n != esperado:
            aviso(f"{arq}: numeração de {nome} salta para {n} (esperado {esperado}) — "
                  f"sintoma clássico de erro LaTeX engolido")
            esperado = n
        esperado += 1


def main() -> int:
    if not APOSTILA.is_dir():
        print(f"ERRO: rode da raiz do workspace (não achei {APOSTILA})", file=sys.stderr)
        return 1

    capitulos = sorted(APOSTILA.glob("capitulo-*.md"))
    if not capitulos:
        print("ERRO: nenhum apostila/capitulo-*.md encontrado", file=sys.stderr)
        return 1

    indice = (APOSTILA / "indice.md").read_text(encoding="utf-8") if (APOSTILA / "indice.md").exists() else ""

    print(f"{'capítulo':<16} {'lin':>5} {'fig':>4} {'mmd':>4} {'tab':>4} {'questões':>8}")
    for arq in capitulos:
        texto = arq.read_text(encoding="utf-8")
        linhas = texto.splitlines()
        # figura = placeholder ("> 🖼️ **[Figura N.M") ou imagem real ("![Figura N.M – ...](...)")
        numeros_fig: list[int] = []
        for linha in linhas:
            m = re.match(r"^>\s*🖼️.*?Figura\s+\d+\.(\d+)", linha) or re.match(
                r"^!\[Figura\s+\d+\.(\d+)", linha
            )
            if m:
                numeros_fig.append(int(m.group(1)))
        figuras = len(numeros_fig)
        reais = sum(1 for linha in linhas if re.match(r"^!\[Figura\s+\d+\.", linha))
        mermaid = len(re.findall(r"^```mermaid", texto, re.M))
        tabelas = len(re.findall(r"^\|\s*-{3,}", texto, re.M))
        questoes = 0
        if re.search(r"^##\s+Questões de Revisão", texto, re.M):
            trecho = re.split(r"^##\s+Questões de Revisão\s*$", texto, flags=re.M)[-1]
            questoes = len(re.findall(r"^\s*\d+[.)]\s", trecho, re.M))
        print(f"{arq.name:<16} {len(linhas):>5} {figuras:>4} {mermaid:>4} {tabelas:>4} {questoes:>8}"
              + (f"   ({reais} real, {figuras - reais} placeholder)" if figuras else ""))

        if figuras < MIN_FIGURAS:
            aviso(f"{arq.name}: {figuras} figura(s) — mínimo {MIN_FIGURAS}")
        if mermaid < MIN_MERMAID:
            aviso(f"{arq.name}: {mermaid} diagrama(s) Mermaid — mínimo {MIN_MERMAID}")
        if tabelas < 1:
            aviso(f"{arq.name}: sem tabela comparativa")
        if not re.search(r"^##\s+Resumo", texto, re.M):
            erro(f"{arq.name}: falta a seção '## Resumo'")
        if not re.search(r"^##\s+Questões de Revisão", texto, re.M):
            erro(f"{arq.name}: falta a seção '## Questões de Revisão'")
        elif questoes < MIN_QUESTOES:
            aviso(f"{arq.name}: {questoes} questões de revisão — recomendado {MIN_QUESTOES}+")
        if not re.search(r"^##\s+Referências", texto, re.M):
            erro(f"{arq.name}: falta a seção '## Referências'")

        # figuras/tabelas fora de sequência (numeração manual precisa casar com o LaTeX).
        # Contar apenas LEGENDAS (linha própria), não referências no meio da frase:
        # "(Tabela 10.5)" citada no texto não é uma nova tabela.
        legendas_tab = re.findall(r"^\*\*Tabela\s+\d+\.(\d+)", texto, re.M)
        numeracao_sem_buraco(numeros_fig, "figura", arq.name)
        numeracao_sem_buraco([int(m) for m in legendas_tab], "tabela", arq.name)

        # caixas de destaque só com os 4 emojis previstos (⚠️/🖼️ têm variation selector)
        for token in re.findall(r"^>\s*(\S+)", texto, re.M):
            simbolo = token.rstrip("*")
            if simbolo in EMOJIS_OK or re.search(r"[0-9A-Za-zÀ-ÿ]", simbolo):
                continue
            if simbolo in {"-", "—", "–", "$"}:
                continue
            aviso(f"{arq.name}: caixa de destaque com símbolo fora do padrão: {simbolo!r}")

        # código largo demais (quebra no PDF e desalinha desenho ASCII)
        for inicio, lang, buf in blocos_codigo(texto):
            if lang == "mermaid":   # vira imagem; largura de linha não importa
                continue
            largas = [i for i, l in enumerate(buf) if len(l) > LIMITE_LINHA_CODIGO]
            if largas:
                aviso(f"{arq.name}:{inicio} bloco '{lang or 'sem linguagem'}' com "
                      f"{len(largas)} linha(s) > {LIMITE_LINHA_CODIGO} col. "
                      f"(1ª na linha {inicio + 1 + largas[0]})")

        # registro no sumário (é dele que o HTML tira a navegação)
        if f"{arq.stem}.md" not in indice:
            erro(f"{arq.name}: ausente do sumário em apostila/indice.md")

    # duplicação de capítulos: apostila/ é a única fonte de verdade desde 2026-09
    if COPIA.is_dir():
        duplicados = sorted(p.name for p in COPIA.glob("*.md"))
        if duplicados:
            erro(f"docs/apostila/ tem cópias de capítulo ({', '.join(duplicados)}) — "
                 f"a fonte de verdade é apostila/; remova as cópias")
        # HTML: o rebuild.py lê de apostila/ e escreve docs/apostila/apostila-scada.html
        html = COPIA / "apostila-scada.html"
        if not html.exists():
            aviso("docs/apostila/apostila-scada.html não existe — rode: python3 docs/apostila/rebuild.py")
        else:
            mais_novo = max((p.stat().st_mtime for p in APOSTILA.glob("*.md")), default=0)
            if html.stat().st_mtime < mais_novo:
                aviso("docs/apostila/apostila-scada.html está desatualizado em relação a "
                      "apostila/ — rode: python3 docs/apostila/rebuild.py")
    else:
        aviso("docs/apostila/ não existe (a versão web não é gerada)")

    # dívidas declaradas
    pendentes = 0
    for arq in capitulos:
        pendentes += len(re.findall(r"ainda não renderizado|TODO|FIXME|XXX", arq.read_text(encoding="utf-8")))
    if pendentes:
        aviso(f"{pendentes} marcador(es) de pendência (TODO/FIXME/diagrama não renderizado)")

    print()
    for e in erros:
        print(f"ERRO   {e}")
    for a in avisos:
        print(f"AVISO  {a}")
    print(f"\n{len(erros)} erro(s), {len(avisos)} aviso(s).")
    return 1 if erros else 0


if __name__ == "__main__":
    sys.exit(main())
