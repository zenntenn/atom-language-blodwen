BlodwenIdeMode = require './blodwen-ide-mode'
Logger = require './utils/Logger'
Rx = require 'rx-lite'
JS = require './utils/js'
path = require 'path'

class BlodwenModel
  requestId: 0
  ideModeRef: null
  subjects: { }
  warnings: { }
  compilerOptions: { }
  oldCompilerOptions: { }

  ideMode: (compilerOptions) ->
    if @ideModeRef && (!JS.objectEqual(@oldCompilerOptions, compilerOptions) || not @ideModeRef.running())
      @ideModeRef.process.removeAllListeners()
      @ideModeRef.stop()
      @ideModeRef = null
    if !@ideModeRef
      @ideModeRef = new BlodwenIdeMode
      @ideModeRef.on 'message', @handleCommand
      @ideModeRef.start compilerOptions
      @oldCompilerOptions = compilerOptions
    @ideModeRef

  stop: ->
    @ideModeRef?.stop()

  setCompilerOptions: (options) ->
    @compilerOptions = options

  handleCommand: (cmd) =>
    if cmd.length > 0
      [op, params..., id] = cmd
      if @subjects[id]?
        subject = @subjects[id]
        switch op
          when ':return'
            ret = params[0]
            if ret[0] == ':ok'
              okparams = ret[1]
              if okparams[0] == ':metavariable-lemma'
                subject.onNext
                  responseType: 'return'
                  msg: okparams
              else
                subject.onNext
                  responseType: 'return'
                  msg: ret.slice(1)
            else
              subject.onError
                message: ret[1]
                warnings: @warnings[id]
                highlightInformation: ret[2]
                cwd: @compilerOptions.src
            subject.onCompleted()
            delete @subjects[id]
          when ':write-string'
            msg = params[0]
            subject.onNext
              responseType: 'write-string'
              msg: msg
          when ':warning'
            warning = params[0]
            @warnings[id].push warning
          when ':run-program'
            options =
              detail: "The path for the compiled program. It was copied to your clipboard. Paste it into a terminal to execute."
              dismissible: true
              icon: "comment"
              buttons: [
                {text: "Confirm"}
              ]
            atom.clipboard.write params[0]
            atom.notifications.addSuccess params[0], options
          when ':set-prompt'
            # Ignore
          else
            console.log op, params

  getUID: -> ++@requestId

  prepareCommand: (cmd) ->
    id = @getUID()
    subject = new Rx.Subject
    @subjects[id] = subject
    @warnings[id] = []
    @ideMode(@compilerOptions).send [cmd, id]
    subject

  changeDirectory: (dir) ->
    @interpret ":cd #{dir}"

  load: (uri) ->
    dir =
      if @compilerOptions.src
        @compilerOptions.src
      else
        path.dirname uri

    cd =
      if dir != @compilerOptions.src
        @compilerOptions.src = dir
        @changeDirectory dir
          .map (_) -> dir
      else
        Rx.Observable.of dir

    cd.flatMap (_) =>
      @prepareCommand [':load-file', uri]

  docsFor: (word) ->
    @prepareCommand [':docs-for', word]

  replCompletions: (word) ->
      @prepareCommand [':repl-completions', word]

  getType: (word) ->
    @prepareCommand [':type-of', word]

  caseSplit: (line, word) ->
    @prepareCommand [':case-split', line, word]

  makeWith: (line, word) ->
    @prepareCommand [':make-with', line, word]

  makeLemma: (line, word) ->
    @prepareCommand [':make-lemma', line, word]

  interpret: (code) ->
    @prepareCommand [':interpret', code]

  makeCase: (line, word) ->
    @prepareCommand [':make-case', line, word]

  addClause: (line, word) ->
    @prepareCommand [':add-clause', line, word]

  addProofClause: (line, word) ->
    @prepareCommand [':add-proof-clause', line, word]

  holes: (width) ->
    @prepareCommand [':metavariables', width]

  proofSearch: (line, word) ->
    @prepareCommand [':proof-search', line, word, []]

  printDefinition: (name) ->
    @prepareCommand [':print-definition', name]

  apropos: (name) ->
    @prepareCommand [':apropos', name]

  browseNamespace: (name) ->
    @prepareCommand [':browse-namespace', name]

module.exports = BlodwenModel
