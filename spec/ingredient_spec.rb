require 'spec_helper'

describe(Ingredient) do
  it('tells you what recipes it is in') do
    ingredient = Ingredient.create({ingredient: 'egg'})
    recipe = Recipe.create({name: "Austin's diet"})
    ingredient.recipes.push(recipe)
    expect(ingredient.recipes).to(eq([recipe]))
  end
end
