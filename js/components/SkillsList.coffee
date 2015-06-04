skills = require '../skills'
component = require '../component'
{div} = require '../DOM'

SkillsList = component

  getInitialState: ->
    skills: null

  componentDidMount: ->
    skills.load().then(
      (skills) => @setState skills: skills,
      (error) => @setState error: error,
    )

  render: ->
    return div(null, "Failed to load skills: #{@state.error}") if @state.error
    
    return div(null, 'loading...') unless @state.skills?

    skill_components = @state.skills.map (skill, index) ->
      Skill(key: index, skill: skill)
    
    div(null, skill_components)


Skill = component
  render: ->
    div(null, @props.skill.name)



module.exports = SkillsList