$ = require 'jquery'

module.exports = 
  load: ->
    $.getJSON('/skills').promise()