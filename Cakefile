fs = require 'fs'
{spawn} = require 'child_process'

appFiles  = [
  # omit src/ and .coffee to make the below lines a little shorter
]
    
binDir = './node_modules/.bin'
nodeDev = "#{binDir}/node-dev"
mocha = "#{binDir}/mocha"
npmedge = "#{binDir}/npmedge"

option '-p', '--port [PORT_NUMBER]', 'set the port number for `start`'
option '-e', '--environment [ENVIRONMENT_NAME]', 'set the environment for `start`'
task 'start', 'start the server', (options) ->
  process.env.NODE_ENV = options.environment ? 'development'
  process.env.PORT = options.port if options.port
  spawn nodeDev, ['server.js'], stdio: 'inherit'

  
task 'build', 'Build single application file from source files', ->
  appContents = new Array remaining = appFiles.length
  for file, index in appFiles then do (file, index) ->
    fs.readFile "src/#{file}.coffee", 'utf8', (err, fileContents) ->
      throw err if err
      appContents[index] = fileContents
      process() if --remaining is 0
  process = ->
    fs.writeFile 'lib/app.coffee', appContents.join('\n\n'), 'utf8', (err) ->
      throw err if err
      exec 'coffee --compile lib/app.coffee', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
        fs.unlink 'lib/app.coffee', (err) ->
          throw err if err
          console.log 'Done.'
           
task 'test', 'run the tests', ->
  process.env.NODE_ENV = 'test'
  args = [
    '--compilers', 'coffee:coffee-script'
    '--require', './server'
    '--require', 'should'
    '--reporter', 'list'
    '--recursive'
    './app/test'
  ]
  spawn mocha, args, stdio: 'inherit'

task 'update', 'update all packages and run npmedge', ->
  (spawn 'npm', ['install', '-q'], stdio: 'inherit').on 'exit', ->
    (spawn 'npm', ['update', '-q'], stdio: 'inherit').on 'exit', ->
      spawn npmedge, [], stdio: 'inherit'
