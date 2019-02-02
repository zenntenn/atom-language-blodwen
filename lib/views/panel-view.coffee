REPLView = require './repl-view'
AproposView = require './apropos-view'

class BlodwenPanel
  constructor: (@controller, @panel) ->

  getTitle: ->
    switch @panel
      when "repl" then "Blodwen: REPL"
      when "apropos" then "Blodwen: Apropos"
      else "Blodwen ?"

  getViewClass: ->
    switch @panel
      when "repl" then REPLView
      when "apropos" then AproposView

  getURI: ->
    switch @panel
      when "repl" then "blodwen://repl"
      when "apropos" then "blodwen://apropos"

module.exports =
  BlodwenPanel: BlodwenPanel
