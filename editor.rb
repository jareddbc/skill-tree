require File.expand_path('../environment', __FILE__)
require 'sinatra'
require Bundler.root + 'skill'

configure do
  set :root, Bundler.root
  set :views, Bundler.root + 'editor/views'
end

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





