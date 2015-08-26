require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all

  erb :index
end

post '/recipes/new' do
  name = params.fetch('name')

  Recipe.create({name: name})

  redirect '/'
end

get '/recipes/:id' do
  id = params.fetch('id')
  @recipe = Recipe.find(id)
  @ingredients = @recipe.ingredients

  erb :recipe
end
