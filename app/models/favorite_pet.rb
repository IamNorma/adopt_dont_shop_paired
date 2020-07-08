class FavoritePet < ApplicationRecord
  belongs_to :favorite
  belongs_to :pet
end
