require 'bundler'
Bundler.setup

require 'sinatra'

require Bundler.root + 'skill'

get '/' do
  content_type :text
  Skill.all.inspect
end