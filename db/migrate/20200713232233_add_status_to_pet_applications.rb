class AddStatusToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :status, :boolean, default: false
  end
end
