require! <[ livescript through ]>

const options = {+bare, map: 'embedded'}

const compile = (file, data) ->
    compiled = livescript.compile data, {filename: file} <<< options
    compiled.code + '\n'

const is-live = (file) -> /.*\.ls$/.test file

module.exports = (file) ->
    unless is-live file
        return through!
    data = ''
    const write = !-> data += it
    const end = !->
        try
            src = compile file, data
        catch
            @emit \error e
        @queue src
        @queue null
    through write, end
