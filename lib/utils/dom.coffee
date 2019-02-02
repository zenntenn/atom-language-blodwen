joinHtmlElements = (containerElem, elems) ->
  div = document.createElement containerElem
  elems.forEach (elem) ->
    div.appendChild elem
  div

createCodeElement = ->
  pre = document.createElement 'pre'
  fontFamily = atom.config.get 'language-blodwen.panelFontFamily'
  if fontFamily != ''
    pre.style.fontFamily = fontFamily
  fontSize = atom.config.get 'language-blodwen.panelFontSize'
  pre.style.fontSize = "#{fontSize}px"
  enableLigatures = atom.config.get 'language-blodwen.panelFontLigatures'
  if enableLigatures
    pre.style.webkitFontFeatureSettings = '"liga"'
  pre

fontOptions = ->
  fontSize = atom.config.get 'language-blodwen.panelFontSize'
  fontSizeAttr = "#{fontSize}px"
  enableLigatures = atom.config.get 'language-blodwen.panelFontLigatures'
  webkitFontFeatureSettings =
    if enableLigatures
      '"liga"'
    else
      '"inherit"'

  fontFamily = atom.config.get 'language-blodwen.panelFontFamily'
  if fontFamily != ''
    fontFamily
  else
    '"inherit"'

  'font-size': fontSizeAttr
  '-webkit-font-feature-settings': webkitFontFeatureSettings
  'font-family': fontFamily


module.exports =
  joinHtmlElements: joinHtmlElements
  createCodeElement: createCodeElement
  fontOptions: fontOptions
