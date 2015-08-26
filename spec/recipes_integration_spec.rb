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
      visit('/recipes/#{rec.id}')
      expect(page).to have_content("bacon")
    end
  end
end
