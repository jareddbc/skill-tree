$ = require 'jquery'
React = require 'react'
component = require './component'
{div} = require './DOM'

skills = require './skills'
window.skills = skills # DEBUG

Skills = component

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

    skills = @state.skills.map (skill, index) ->
      Skill(key: index, skill: skill)
    
    div(null, skills)

Skill = component
  render: ->
    div(null, @props.skill.name)


$ ->
  React.render(Skills(), document.body)