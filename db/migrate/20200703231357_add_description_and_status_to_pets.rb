class AddDescriptionAndStatusToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :description, :string
    add_column :pets, :status, :boolean
  end
end
