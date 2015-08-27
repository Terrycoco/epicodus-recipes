require 'bundler/setup'
Bundler.require :default

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all
  @ingredients = Ingredient.all

  erb :index
end

get '/recipes/ingredient' do
  ingredient_id = params.fetch('ingredient_id')
  ingredient = Ingredient.find(ingredient_id)
  @recipes = ingredient.recipes
  @ingredients = Ingredient.all

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
  rating = params.fetch('rating').to_i
  recipe.update(yield: _yield, name: name, instr: instr, rating: rating)
  redirect("/recipes/#{recipe.id}/edit")
end

post '/recipes/:id/add_ingr' do
  recipe = Recipe.find(params.fetch('id'))
  _yield = params.fetch('yield')
  name = params.fetch('name')
  instr = params.fetch('instr')
  rating = params.fetch('rating')
  recipe.update(yield: _yield, name: name, instr: instr, rating: rating)
  ingr = Ingredient.create(ingredient: params.fetch('ingredient'))
  recipe.ingredients.push(ingr)
  redirect("/recipes/#{recipe.id}/edit")
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

get '/tags' do
  @tags = Tag.all
  erb(:tag)
end

post "/recipe/:id/delete" do
  rid = params.fetch('id')
  recipe = Recipe.find(rid)
  Recipe.destroy(recipe)
  redirect '/'
end

get "/ingredient_filter" do
  filter = params.fetch('filter').downcase
  whereclause = "lower(ingredient) like '%" + filter + "%'"
  @recipes = Recipe.joins(:ingredients).where(whereclause).distinct.order("Name ASC")
  @ingredients = Ingredient.all
  erb :index
end

get '/edit_tags' do
  @tags = Tag.all

  erb(:edit_tags)
end

delete '/tags/:id/delete' do
  id = params.fetch('id')
  tag = Tag.find(id)
  Tag.destroy(tag)

  redirect '/edit_tags'
end

get '/ingredients' do
  @ingredients = Ingredient.all
  erb(:ingredient)
end

get '/edit_ingredients' do
  @ingredients = Ingredient.all

  erb(:edit_ingredients)
end

delete '/ingredients/:id/delete' do
  id = params.fetch('id')
  ingredient = Ingredient.find(id)
  Ingredient.destroy(ingredient)

  redirect '/edit_ingredients'
end
