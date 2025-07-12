function CodeBlock(code)
  if (code.classes:includes("control")) then
   
    targetType = pandoc.utils.stringify(code.attributes["target"])
    local codePayload = pandoc.utils.stringify(code.text)
    local IfrrameUrl = "https://pages.icpmol.es/ControlChallenges/index.html"
    local url = IfrrameUrl .. "?target=" .. targetType .. '&code=' .. quarto.base64.encode(codePayload)
    local cssStyle = 'width:100%;height:90vh;border-width:3px;border-style:dashed'



    if quarto.doc.isFormat('html')  then
      return pandoc.RawBlock('html',  '<iframe src="' .. url .. '" style=' .. cssStyle .. '></iframe>' .. '<a href='.. url ..' class="simulation-url">Open Simulation</a>')
    else
      return pandoc.Link({pandoc.Str "Open Simulation"}, url)
    end
  end
end
