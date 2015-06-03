require File.expand_path('../environment', __FILE__)
require 'sinatra'
require Bundler.root + 'skill'

configure do
  set :root,   Bundler.root
  set :views,  'editor/views'
  set :public, 'editor/public'
end

get '/' do
  erb :index
end

get '/skills' do
  content_type :json
  Skill.read.to_json
end

