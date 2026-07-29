local Strings
Strings = {
  marquee = function(text, width, speed)
    if vim.fn.strdisplaywidth(text) <= width then
      return text
    end

    local now = vim.uv.now() / 1000
    local total = vim.fn.strdisplaywidth(text)

    local cycle = total + width
    local offset = math.floor(now * speed) % cycle

    local left_pad = math.max(0, width - offset)
    local skip = math.max(0, offset - width)

    local out = {}

    if left_pad > 0 then
      out[#out + 1] = string.rep(" ", left_pad)
    end

    local skipped = 0
    local shown = left_pad

    local i = 0
    while true do
      local ch = vim.fn.strcharpart(text, i, 1)
      if ch == "" then
        break
      end

      local w = vim.fn.strdisplaywidth(ch)

      if skipped + w <= skip then
        skipped = skipped + w
      elseif shown + w <= width then
        out[#out + 1] = ch
        shown = shown + w
      else
        break
      end

      i = i + 1
    end

    if shown < width then
      out[#out + 1] = string.rep(" ", width - shown)
    end

    return table.concat(out)
  end
}
return Strings
