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

get '/recipes/:id/edit' do
  id = params.fetch('id')
  @recipe = Recipe.find(id)

  erb :recipe_edit
end

post '/recipes/:id/update' do
  recipe = Recipe.find(params.fetch('id'))
  _yield = params.fetch('yield')
  name = params.fetch('name')
  instr = params.fetch('instr')
  recipe.update(yield: _yield, name: name, instr: instr)
  redirect("/recipes/#{recipe.id}")
end

post '/recipes/:id/add_ingr' do
  recipe = Recipe.find(params.fetch('id'))
  _yield = params.fetch('yield')
  name = params.fetch('name')
  instr = params.fetch('instr')
  recipe.update(yield: _yield, name: name, instr: instr)
  ingr = Ingredient.create(ingredient: params.fetch('ingredient'))
  recipe.ingredients.push(ingr)
  redirect("/recipes/#{recipe.id}")
end
