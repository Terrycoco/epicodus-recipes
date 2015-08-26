class RemoveQuantityAndMeasurement < ActiveRecord::Migration
  def change
    remove_column(:ingredients_recipes, :quantity)
    remove_column(:ingredients_recipes, :measurement)

    add_column(:ingredients_recipes, :amount, :string)

    change_table :recipes do |t|
      t.timestamps
    end

    change_table :tags do |t|
      t.timestamps
    end

    change_table :ingredients do |t|
      t.timestamps
    end

    change_table :ingredients_recipes do |t|
      t.timestamps
    end

    change_table :recipes_tags do |t|
      t.timestamps
    end

  end
end
