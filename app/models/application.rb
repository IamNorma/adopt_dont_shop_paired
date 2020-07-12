class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone, :description
end
