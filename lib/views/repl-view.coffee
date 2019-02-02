Cycle = require '@cycle/core'
CycleDOM = require '@cycle/dom'
highlighter = require '../utils/highlighter'
Rx = require 'rx-lite'
{ fontOptions } = require '../utils/dom'

styles = fontOptions()

# highlight : forall a.
#   { code : String, highlightInformation : HighlightInformation } ->
#   CycleDOM
highlight = ({ code, highlightInformation }) ->
  if highlightInformation
    highlights = highlighter.highlight code, highlightInformation
    highlighter.highlightToCycle highlights
  else
    code

displaySuccess = (line) ->
  highlightedCode = highlight line

  CycleDOM.h 'pre',
    {
      className: 'blodwen-repl-output'
      style: styles
    },
    [
      highlightedCode
    ]

displayError = (line) ->
  highlightedCode = highlight line

  CycleDOM.h 'pre', { }, highlightedCode

REPLCycle =
  # view : Observable State -> Observable CycleDOM
  view: (state$) ->
    state$.map (lines) ->
      lines = lines.map (line) ->
        answer =
          if line.type == 'success'
            displaySuccess line
          else
            displayError line

        CycleDOM.h 'div',
          {
            className: 'blodwen-repl-line'
            style: styles
          },
          [
            CycleDOM.h 'div', { className: 'blodwen-repl-input' },
              [
                CycleDOM.h 'span', { className: 'blodwen-repl-input-prompt' }, '> '
                line.input
              ]
            answer
          ]

      CycleDOM.h 'div',
        {
          className: 'blodwen-panel-view'
        },
        [
          CycleDOM.h 'input', { type: 'text', className: 'native-key-bindings blodwen-repl-input-field' }, ''
          CycleDOM.h 'div', { className: 'blodwen-repl-lines' }, lines
        ]

  main: (responses) ->
    input = responses.DOM.select('input').events('keydown')
      .filter (ev) -> ev.keyCode == 13
      .map (ev) -> ev.target.value
      .startWith ''

    DOM: REPLCycle.view responses.CONTENT
    CONTENT: input

  driver:
    (options) ->
      DOM: CycleDOM.makeDOMDriver options.hostElement
      CONTENT: (inp) ->
        inp
          .filter (line) -> line != ''
          .flatMap (line) ->
            escapedLine = line.replace(/"/g, '\\"')
            # append a space to trick the formatter, so that it wont turn
            # the input into a symbol
            options.model.interpret "#{escapedLine} "
              .map (e) ->
                type: 'success'
                input: line
                code: e.msg[0]
                highlightInformation: e.msg[1]
              .catch (e) ->
                Rx.Observable.just
                  type: 'error'
                  input: line
                  code: e.message
                  highlightInformation: e.highlightInformation
                  warnings: e.warnings
          .scan ((acc, x) -> [x].concat acc), []
          .startWith []

class REPLView
  constructor: (params) ->
    hostElement = document.createElement 'div'
    @[0] = hostElement

    model = params.controller.model

    drivers =
      REPLCycle.driver
        hostElement: hostElement
        model: model

    Cycle.run REPLCycle.main, drivers

module.exports = REPLView
