component = require '../component'
ActionLink = require './ActionLink'
{div, a, h1} = require '../DOM'

module.exports = component
  render: ->
    div(className: 'layout', 
      ActionLink(href:'/', h1(null, 'DBC Skill Tree')),
      @props.children,
    )
