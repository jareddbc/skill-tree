require 'bundler'
Bundler.setup

require 'sinatra'

require Bundler.root + 'skill'

get '/' do
  @skills = Skill.all.sort_by(&:id)
  haml :index
end


__END__

@@ layout
%html
  %body
    = yield

@@ index
.skills
  - @skills.each do |skill|
    %form
      %label
        %div
          ID: 
          = skill.id
      %label
        %div Name:
        %input{type:'text', name:'name', value: skill.name}
      %label
        %div Depenencies:
        %select{multiple: true}
          - @skills.each do |option|
            %option{value:option.id, selected: skill.dependent_on?(option)}= option.name





