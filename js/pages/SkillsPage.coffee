skills = require '../skills'
component = require '../component'

Layout = require '../components/Layout'
SkillsList = require '../components/SkillsList'
{div, h3} = require '../DOM'

module.exports = component

  render: ->
    Layout(null, 
      h3(null, 'Skills:'),
      SkillsList(),
    )