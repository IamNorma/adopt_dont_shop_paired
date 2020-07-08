class CreateFavoritePets < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_pets do |t|
      t.references :pet, foreign_key: true
      t.references :favorite, foreign_key: true

      t.timestamps
    end
  end
end
