$ = require 'jquery'
React = require 'react'
component = require './component'


Test = component
  render: ->
    React.DOM.div(null, 'love me')

$ ->
  React.render(Test(), document.body)