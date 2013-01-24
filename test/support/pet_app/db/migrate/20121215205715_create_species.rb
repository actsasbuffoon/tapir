class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :name
      t.integer :legs
      t.boolean :tail

      t.timestamps
    end
  end
end
