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
end
