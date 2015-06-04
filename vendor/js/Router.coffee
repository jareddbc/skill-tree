EventEmitter = require('events').EventEmitter
assign       = require('object-assign')

module.exports = (spec) ->

  routes = []

  context = {
    route: (pathname, options) -> 
      routes.push createRoute(pathname, options)
  }

  spec.apply(context)

  return (path) -> findRoute(routes, path)


createRoute = (pathname, options) ->
  route = {
    pathname: pathname, 
    options: options,
  }
  parseExpression.call(route, pathname)
  route

findRoute = (routes, path) ->
  route = null
  for route in routes
    return route if match(route, path)

match = (route, path) ->
  route.regexp.test(path)




escapeRegExp  = /[\-{}\[\]+?.,\\\^$|#\s]/g
namedParams   = /\/(:|\*)([^\/?]+)/g
parseExpression = (expression) ->
  params = []
  expression = expression.replace(escapeRegExp, '\\$&')
  expression = expression.replace namedParams, (_, type, param) ->
    params.push(param)
    switch type
      when ':' then '/([^/?]+)'
      when '*' then '/(.*?)'

  @params = params
  @regexp = new RegExp("^#{expression}$")