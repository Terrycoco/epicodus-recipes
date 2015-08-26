class CreateRecipes < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:yield, :integer)
      t.column(:instr, :string)
    end

    create_table(:tags) do |t|
      t.column(:tag, :string)
    end

    create_table(:ingredients) do |t|
      t.column(:ingredient, :string)
    end

    create_table(:measurement_lookup, :id => false) do |t|
      t.column(:measurement, :string, :index => true)
    end

    create_table(:ingredients_recipes) do |t|
      t.column(:ingredient_id, :integer)
      t.column(:recipe_id, :integer)
      t.column(:quantity, :decimal, precision: 10, scale: 2)
      t.column(:measurement, :string)
    end

    add_foreign_key :ingredients_recipes, :ingredients
    add_foreign_key :ingredients_recipes, :recipes

    create_table(:recipes_tags) do |t|
     t.column(:recipe_id, :integer)
     t.column(:tag_id, :integer)
    end

    add_foreign_key :recipes_tags, :recipes
    add_foreign_key :recipes_tags, :tags

  end
end
