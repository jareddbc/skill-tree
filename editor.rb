require File.expand_path('../environment', __FILE__)
require 'sinatra'
require Bundler.root + 'skill'

configure do
  set :root, Bundler.root
  set :views, Bundler.root + 'editor/views'
end

get '/' do
  haml :index
end

get '/skills' do
  content_type :json
  Skill.all.to_json
end

