Logger = require './utils/Logger'
sexpFormatter = require './utils/sexp-formatter'
parse = require './utils/parse'
{ EventEmitter } = require 'events'
{ spawn } = require 'child_process'

class BlodwenIdeMode extends EventEmitter
  process: null
  buffer: ''
  blodwenBuffers: 0
  compilerOptions: { }

  start: (compilerOptions) ->
    if (not @process?) || @process.killed
      pathToBlodwen = atom.config.get("language-blodwen.pathToBlodwen")
      pkgs =
        if compilerOptions.pkgs && compilerOptions.pkgs.length
          p = compilerOptions.pkgs.map (p) -> ["-p", p]
          [].concat.apply([], p)
        else
          []

      options =
        if compilerOptions.options
          compilerOptions.options.split(' ')
        else
          []

      tabLength = atom.config.get('editor.tabLength', scope: ['source.blodwen'])
      configParams = ['--ide-mode', '--indent-with=' + tabLength,
                      '--indent-clause=' + tabLength]

      parameters =
        configParams.concat pkgs, options

      options =
        if compilerOptions.src
          cwd: compilerOptions.src
        else
          { }
      @process =
        spawn pathToBlodwen, parameters, options
      @process.on 'error', @error
      @process.on 'exit', @exited
      @process.on 'close', @exited
      @process.on 'disconnect', @exited

      @process.stdout.setEncoding('utf8').on 'data', @stdout

  setCompilerOptions: (options) ->
    @compilerOptions options

  send: (cmd) ->
    Logger.logOutgoingCommand cmd
    @process.stdin.write sexpFormatter.serialize(cmd)

  stop: ->
    @process?.kill()

  error: (error) ->
    e =
      if error.code == 'ENOENT'
        short: "Couldn't find blodwen executable"
        long: "Couldn't find blodwen executable at \"#{error.path}\""
      else
        short: error.code
        long: error.message

    atom.notifications.addError e.short, detail: e.long

  exited: (code, signal) ->
    if signal == "SIGTERM"
      short = "The blodwen compiler was closed"
      long = "You stopped the compiler"
      atom.notifications.addInfo short, detail: long
    else
      short = "The blodwen compiler was closed or crashed"
      long =
        if signal
          "It was closed with the signal: #{signal}"
        else
          "It (probably) crashed with the error code: #{code}"
      atom.notifications.addError short, detail: long

  running: ->
    !!@process && !@process.killed

  stdout: (data) =>
    @buffer += data
    while @buffer.length > 6
      @buffer = @buffer.trimLeft().replace /\r\n/g, "\n"
      # We have 6 chars, which is the length of the command
      len = parseInt(@buffer.substr(0, 6), 16)
      if @buffer.length >= 6 + len
        # We also have the length of the command in the buffer, so
        # let's read in the command
        cmd = @buffer.substr(6, len).trim()
        Logger.logIncomingCommand cmd
        # Remove the length + command from the buffer
        @buffer = @buffer.substr(6 + len)
        # And then we can try to parse to command..
        obj = parse.parse(cmd.trim())
        @emit 'message', obj
      else
        # We didn't have the entire command, so let's break the
        # while-loop and wait for the next data-event
        break

module.exports = BlodwenIdeMode
