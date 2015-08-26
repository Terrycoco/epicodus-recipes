class DeleteAmountFromIngredientsRecipes < ActiveRecord::Migration
  def change
    remove_column(:ingredients_recipes, :amount)
  end
end
