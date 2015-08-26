require 'spec_helper'

describe(Recipe) do
  it('tells you what ingredients it uses') do
    recipe = Recipe.create({name: "Austin's diet"})
    ingredient = Ingredient.create({ingredient: "egg"})
    recipe.ingredients.push(ingredient)
    expect(recipe.ingredients).to(eq([ingredient]))
  end
end
