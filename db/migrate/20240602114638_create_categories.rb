class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.text :description

      t.timestamps
    end
  end
end
