class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.references :species
      t.string :name
      t.references :owner
      t.string :gender

      t.timestamps
    end
    add_index :animals, :species_id
    add_index :animals, :owner_id
  end
end
