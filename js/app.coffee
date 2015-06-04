$ = require 'jquery'
React = require 'react'
component = require './component'
router = require('./router')
Path = require 'Path'

{div} = require './DOM'

path = Path(window)

getState = ->
  path: path
  route: router(path)

App = component

  childContextTypes:
    path: React.PropTypes.object

  getChildContext: ->
    path: path

  getInitialState: ->
    getState()

  onChange: ->
    @setState getState()

  componentDidMount: ->
    # session.on('change', @onChange)
    path.on('change', @onChange)

  componentWillUnmount: ->
    # session.removeListener('change', @onChange)
    path.removeListener('change', @onChange)
  
  render: ->
    console.log('RENDERING:', state: @state)

    route = @state.route
    Page = route.options.to
    Page(route: route)


$ ->
  React.render(App(), document.body)




# FOR DEBUG
window.DEBUG_SKILLS = require './skills'
window.DEBUG_PATH = path
window.DEBUG_ROUTER = router