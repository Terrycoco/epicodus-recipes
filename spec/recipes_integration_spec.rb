require 'spec_helper'

describe('the chef path') do
  describe('home page', {:type => :feature}) do
    it('allows you to add a new recipe and display a form to edit that recipe.') do
      visit('/')
      fill_in('name', with: "Austin's wedding cake")
      click_button('+')
      expect(page).to have_content("Austin's wedding cake")
    end
  end

  describe('recipe display page', {:type => :feature})  do
    it('opens a page that displays the recipe as text') do
      rec = Recipe.create({name: "Austin's Eggs"})
      ingr = Ingredient.create({ingredient: "eggs"})
      rec.ingredients.push(ingr)
      ingr = Ingredient.create({ingredient: "bacon"})
      rec.ingredients.push(ingr)
      visit("/recipes/#{rec.id}")
      expect(page).to have_content("bacon")
    end
  end

  describe('recipe form page', {:type => :feature})  do
    it('opens a form for new recipe') do
      rec = Recipe.create({name: "Austin's Eggs"})
      ingr = Ingredient.create({ingredient: "eggs"})
      rec.ingredients.push(ingr)
      ingr = Ingredient.create({ingredient: "bacon"})
      rec.ingredients.push(ingr)
      visit("/recipes/#{rec.id}/edit")
      expect(page).to have_content("bacon")
    end

    it('allows you to add tags to a recipe') do
      rec = Recipe.create({name: "Austin's Eggs"})
      ingr = Ingredient.create({ingredient: "eggs"})
      rec.ingredients.push(ingr)
      ingr = Ingredient.create({ingredient: "bacon"})
      rec.ingredients.push(ingr)
      tag1 = Tag.create({tag: "Chrismahannukwanzakuhtivus"})
      tag2 = Tag.create({tag: "Breakfast"})
      tag3 = Tag.create({tag: "Lunch"})
      tag4 = Tag.create({tag: "Dinner"})
      tag5 = Tag.create({tag: "Snacks"})
      tag6 = Tag.create({tag: "Tacos"})
      visit("recipes/#{rec.id}/edit")
      page.check(tag1.id)
      page.check(tag2.id)
      page.check(tag3.id)
      page.check(tag4.id)
      click_button('Save Tags')
      expect(rec.tags).to(eq([tag1, tag2, tag3, tag4]))
    end
  end
end
