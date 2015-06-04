require File.expand_path('../environment', __FILE__)
require 'sinatra'
require Bundler.root + 'skill'

configure do
  set :root, Bundler.root
end

get '/skills.json' do
  content_type :json
  Skill.read.to_json
end

get '*' do
  erb :index
end
