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
  @tags = Tag.all

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

post '/recipes/:id/edit_tags' do
  id = params.fetch('id')
  recipe = Recipe.find(id)

  recipe.tags.delete_all

  if params.include?('tag_id')
    tag_id = params.fetch('tag_id')

    tag_id.each do |i|
      t = Tag.find(i)
      recipe.tags.push(t)
    end
  end

  redirect "/recipes/#{recipe.id}/edit"
end

post '/recipes/:id/tags/new' do
  rid = params.fetch('id')
  tag = params.fetch('tag')
  Tag.create(tag: tag)
  redirect("/recipes/#{rid}/edit")
end
