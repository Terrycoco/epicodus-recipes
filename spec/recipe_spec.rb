require 'spec_helper'

describe(Recipe) do
  it('tells you what ingredients it uses') do
    recipe = Recipe.create({name: "Austin's diet"})
    ingredient = Ingredient.create({ingredient: "egg"})
    recipe.ingredients.push(ingredient)
    expect(recipe.ingredients).to(eq([ingredient]))
  end

  it('tells you its tags') do
    recipe = Recipe.create({name: "Austin's diet"})
    tag1 = Tag.create({tag: "breakfast"})
    tag2 = Tag.create({tag: "lunch"})
    tag3 = Tag.create({tag: "dinner"})
    tag4 = Tag.create({tag: "snack"})
    tag5 = Tag.create({tag: "holiday"})

    Tag.all.each do |tag|
      recipe.tags.push(tag)
    end

    expect(recipe.tags).to(eq(Tag.all))
  end
end
