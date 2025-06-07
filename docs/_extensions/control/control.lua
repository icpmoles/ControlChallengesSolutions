return {
  ['control'] = function(args, kwargs, meta, raw_args, context) 
    -- see https://quarto.org/docs/extensions/shortcodes.html
    -- for documentation on shortcode development
    local targetType = pandoc.utils.stringify(kwargs["target"])
    local codePayload = pandoc.utils.stringify(kwargs["code"])
    local IfrrameUrl = "https://pages.icpmol.es/ControlChallenges/index.html"
    local url = IfrrameUrl .. "?target=" .. targetType .. '&code=' .. quarto.base64.encode(codePayload)
    local cssStyle = 'width:100%;height:90vh;border-width:3px;border-style:dashed'

    if quarto.doc.isFormat('hugo') then
      return pandoc.RawBlock('hugo-md',  '{{< control target="' .. targetType .. ' >}}' .. codePayload .. "{{< /control >}}") 
    elseif quarto.doc.isFormat('html')  then
      return pandoc.RawBlock('html',  '<iframe src="' .. url .. '" style=' .. cssStyle .. '></iframe>')
    else
      -- fall back to insert a form feed character
      return pandoc.Para{pandoc.Str '\f'}
    end
  end
}

