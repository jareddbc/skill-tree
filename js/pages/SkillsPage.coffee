SkillsList = require '../components/SkillsList'
{div, h1} = require '../DOM'

module.exports = (props) ->



  div(null, 
    h1('Skills page here'),
    SkillsList(),
  )