Router = require 'Router'

y = require('./pages/RootPage')
x = require('./pages/SkillsPage')
x = require('./pages/SkillsPage')

module.exports = Router ->

  @route '/',                 to: y
  @route '/skills',           to: x
  @route '/skills/:skill_id', to: x
  # @route '*path',             to: 'NotFound'