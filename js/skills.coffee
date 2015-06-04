$ = require 'jquery'

module.exports = 
  load: ->
    $.getJSON('/skills.json').promise()