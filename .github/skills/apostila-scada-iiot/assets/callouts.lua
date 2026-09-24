-- callouts.lua — filtro Pandoc do pipeline Markdown -> LaTeX da apostila.
--
-- 1) Quadros de destaque do Markdown viram caixas tcolorbox:
--      > 📌 **Nota:** ...      -> \begin{caixanota}
--      > ⚠️ **Atenção:** ...   -> \begin{caixaatencao}
--      > 💡 **Dica:** ...      -> \begin{caixadica}
--      > 🖼️ **[Figura N.M…]** -> \begin{caixafigura}
-- 2) Blocos ```mermaid viram figura com figuras/<arquivo>-mK.pdf (gerado por
--    render-mermaid.sh); se o PDF não existir, sai uma nota de pendência.
-- 3) Unicode que o inputenc/utf8 não aceita é convertido (setas, símbolos) e
--    emoji é removido — emoji no texto quebra o pdflatex.

local FORMATO = FORMAT

-- Mapa de símbolos (texto normal) para LaTeX.
local SIMBOLOS = {
  ["\226\134\146"] = "\\ensuremath{\\rightarrow}", -- →
  ["\226\134\144"] = "\\ensuremath{\\leftarrow}",  -- ←
  ["\226\134\145"] = "\\ensuremath{\\uparrow}",    -- ↑
  ["\226\134\147"] = "\\ensuremath{\\downarrow}",  -- ↓
  ["\226\137\136"] = "\\ensuremath{\\approx}",     -- ≈
  ["\226\137\164"] = "\\ensuremath{\\leq}",        -- ≤
  ["\226\137\165"] = "\\ensuremath{\\geq}",        -- ≥
  ["\226\137\160"] = "\\ensuremath{\\neq}",        -- ≠
  ["\195\151"]     = "\\ensuremath{\\times}",      -- ×
  ["\194\177"]     = "\\ensuremath{\\pm}",         -- ±
  ["\206\169"]     = "\\ensuremath{\\Omega}",      -- Ω
  ["\194\181"]     = "\\ensuremath{\\mu}",         -- µ
  ["\194\176"]     = "\\ensuremath{^\\circ}",      -- °
  ["\206\148"]     = "\\ensuremath{\\Delta}",      -- Δ
  ["\206\163"]     = "\\ensuremath{\\Sigma}",      -- Σ
  ["\226\128\147"] = "--",                         -- –
  ["\226\128\148"] = "---",                        -- —
  ["\226\128\156"] = "``",                         -- “
  ["\226\128\157"] = "''",                         -- ”
  ["\226\128\152"] = "`",                          -- ‘
  ["\226\128\153"] = "'",                          -- ’
  ["\226\134\146 "] = "\\ensuremath{\\rightarrow}",
}

-- Fallback para dentro de código (verbatim/listings): precisa ser ASCII.
local SIMBOLOS_CODIGO = {
  ["→"] = "->", ["←"] = "<-", ["↑"] = "^", ["↓"] = "v",
  ["≈"] = "~=", ["≤"] = "<=", ["≥"] = ">=", ["≠"] = "!=",
  ["×"] = "x", ["±"] = "+/-", ["Ω"] = "ohm", ["µ"] = "u",
  ["°"] = " deg", ["Δ"] = "Delta", ["Σ"] = "Sigma",
  ["–"] = "-", ["—"] = "-", ["“"] = '"', ["”"] = '"',
  ["‘"] = "'", ["’"] = "'", ["·"] = ".",
}

local function limpa_codigo(s)
  for de, para in pairs(SIMBOLOS_CODIGO) do s = s:gsub(de, para) end
  -- remove qualquer sobra fora do Latin-1 imprimível (inclui emoji)
  s = s:gsub("[\240-\244][\128-\191][\128-\191][\128-\191]", "")
  s = s:gsub("[\226\128][\128-\191]", "")
  return s
end

-- URL escrita como texto puro (ex.: "siemens.com/global/en/...") não quebra linha e
-- estoura a mancha. Vira \url{...}, que o xurl quebra em qualquer caractere.
local function url_puro(s)
  if not s:find("/", 1, true) then return nil end
  local alvo, cauda = s, ""
  local a, c = s:match("^(.+[%w/])([%.,;:%)]+)$")
  if a then alvo, cauda = a, c end
  -- domínio com ponto + caminho: siemens.com/global/en/..., www.exemplo.org/a/b
  local dominio, resto = alvo:match("^([%w][%w%-%_%.]*%.[%a][%a]+)/(.+)$")
  if dominio and dominio:find(".", 1, true) and #dominio >= 5 and #resto > 0 then
    return alvo, cauda
  end
  return nil
end

-- str -> lista de inlines LaTeX (ou nil se nada mudou)
local function converte_str(s)
  if not s:find("[\194-\244]") then return nil end
  local partes, i = {}, 1
  while i <= #s do
    local b = s:byte(i)
    local n = (b < 128) and 1 or (b < 224) and 2 or (b < 240) and 3 or 4
    local trecho = s:sub(i, i + n - 1)
    local rep = SIMBOLOS[trecho]
    if rep then
      partes[#partes + 1] = pandoc.RawInline("latex", rep)
    elseif b >= 194 and not (b == 194 or b == 195 or b == 206) then
      -- emoji e afins: descarta
      partes[#partes + 1] = pandoc.RawInline("latex", "")
    else
      partes[#partes + 1] = pandoc.Str(trecho)
    end
    i = i + n
  end
  return partes
end

local CAIXAS = {
  ["\240\159\147\140"] = "caixanota",   -- 📌
  ["\226\154\160"]     = "caixaatencao",-- ⚠️ (sem FE0F)
  ["\240\159\146\161"] = "caixadica",   -- 💡
  ["\240\159\150\188"] = "caixafigura", -- 🖼️
}

local function tipo_caixa(texto)
  for emoji, env in pairs(CAIXAS) do
    if texto:find(emoji, 1, true) then return env end
  end
  return "caixanota"
end

local mermaid_n = 0

-- Extrai o número do capítulo a partir do arquivo de entrada (capitulo-07.md).
local function prefixo()
  local arq = (PANDOC_STATE.input_files or {})[1] or "capitulo-00"
  local n = arq:match("capitulo%-(%d+)") or "00"
  return "capitulo-" .. n
end

-- ---------------------------------------------------------------------
-- Figura real + caixa "Fonte" logo depois.
--
-- O pandoc emite um float para a figura (bloco Figure); a caixa "Fonte" é um
-- tcolorbox, que não flutua. Quando a figura ia para o topo da página seguinte,
-- a caixa ficava sozinha na anterior — medido: 12 das 20 figuras reais do PDF.
--
-- Aqui o par vira UM float só: a fonte entra na legenda longa e o rótulo manual
-- continua na legenda curta, que é a que vai para a Lista de Figuras. O Markdown
-- e a versão HTML (rebuild.py) não mudam: o quadro "Fonte" continua no texto; é
-- só o PDF que o integra à legenda, para os dois nunca se separarem.
-- ---------------------------------------------------------------------

-- Figure = "![legenda](arquivo)" sozinho na linha
local function figura_solta(el)
  if not el or el.t ~= "Figure" then return nil end
  local cap = el.caption and el.caption.long
  if not cap or #cap ~= 1 then return nil end
  if cap[1].t ~= "Plain" and cap[1].t ~= "Para" then return nil end
  if #cap[1].content == 0 then return nil end
  return cap[1].content
end

-- BlockQuote "> **Fonte:** ..." -> inlines da caixa inteira (com o rótulo)
local function inlines_da_fonte(el)
  if not el or el.t ~= "BlockQuote" then return nil end
  if #el.content ~= 1 or el.content[1].t ~= "Para" then return nil end
  local ils = el.content[1].content
  local rotulo = ils[1]
  if not (rotulo and rotulo.t == "Strong") then return nil end
  if pandoc.utils.stringify(rotulo) ~= "Fonte:" then return nil end
  if #ils < 2 then return nil end
  return ils
end

-- ATENÇÃO: dentro de UM mesmo filtro o pandoc percorre os inlines antes do bloco, e o
-- emoji da caixa seria removido antes de o BlockQuote ser lido. Por isso os filtros são
-- separados: primeiro a fusão figura+fonte (que precisa do BlockQuote ainda cru),
-- depois as caixas de destaque, por último a limpeza de Unicode.
return {
  {
    Blocks = function(blocos)
      if FORMATO ~= "latex" then return nil end
      local saida, i, mudou = {}, 1, false
      while i <= #blocos do
        local el = blocos[i]
        local usados = 1
        local legenda = figura_solta(el)
        local fonte = legenda and inlines_da_fonte(blocos[i + 1]) or nil
        if fonte then
          local longo = {}
          for _, x in ipairs(legenda) do longo[#longo + 1] = x end
          while #longo > 0
            and (longo[#longo].t == "Space" or longo[#longo].t == "SoftBreak") do
            table.remove(longo)
          end
          longo[#longo + 1] = pandoc.Str(".")
          longo[#longo + 1] = pandoc.Space()
          for _, x in ipairs(fonte) do longo[#longo + 1] = x end
          -- o pandoc 3.1 não expõe pandoc.Caption(): os campos são alterados no lugar
          el.caption.long = pandoc.Blocks({ pandoc.Plain(longo) })
          el.caption.short = pandoc.Inlines(legenda)
          usados, mudou = 2, true
        end
        saida[#saida + 1] = el
        i = i + usados
      end
      if not mudou then return nil end
      return pandoc.Blocks(saida)
    end,
  },

  {
    BlockQuote = function(el)
      if FORMATO ~= "latex" then return nil end
      local texto = pandoc.utils.stringify(el.content)
      local env = tipo_caixa(texto)
      local out = { pandoc.RawBlock("latex", "\\begin{" .. env .. "}") }
      for _, b in ipairs(el.content) do out[#out + 1] = b end
      out[#out + 1] = pandoc.RawBlock("latex", "\\end{" .. env .. "}")
      return out
    end,

    CodeBlock = function(el)
      if FORMATO ~= "latex" then return nil end
      if el.classes:includes("mermaid") then
        mermaid_n = mermaid_n + 1
        local arq = "../figuras/" .. prefixo() .. "-m" .. mermaid_n .. ".pdf"
        return pandoc.RawBlock("latex", table.concat({
          "\\begin{center}",
          "\\IfFileExists{" .. arq .. "}{%",
          "  \\includegraphics[width=\\linewidth,height=0.8\\textheight,keepaspectratio]{" .. arq .. "}%",
          "}{\\fbox{\\parbox{0.9\\linewidth}{\\small Diagrama Mermaid ainda não renderizado: "
            .. prefixo() .. "-m" .. mermaid_n .. ". Rode scripts/render-mermaid.sh.}}}",
          "\\end{center}",
        }, "\n"))
      end
      return nil
    end,
  },
  {
    CodeBlock = function(el)
      if FORMATO ~= "latex" then return nil end
      el.text = limpa_codigo(el.text)
      return el
    end,

    Code = function(el)
      if FORMATO ~= "latex" then return nil end
      el.text = limpa_codigo(el.text)
      return el
    end,

    Str = function(el)
      if FORMATO ~= "latex" then return nil end
      local url, cauda = url_puro(el.text)
      if url then
        local out = { pandoc.RawInline("latex", "\\url{" .. url .. "}") }
        if cauda ~= "" then out[#out + 1] = pandoc.Str(cauda) end
        return out
      end
      return converte_str(el.text)
    end,
  },
}
