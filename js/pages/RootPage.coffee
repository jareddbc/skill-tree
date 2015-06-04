Layout = require '../components/Layout'
ActionLink = require '../components/ActionLink'

{div, h3} = require '../DOM'


module.exports = (props) ->

  Layout(null, 
    h3(null, 'Root page here'),
    ActionLink(href:'/skills', 'skills'),
  )