class Favorite < ApplicationRecord
  has_many :favorite_pets
  has_many :pets, through: :favorite_pets

  def increment
    @favorite.count += 1
  end
end
