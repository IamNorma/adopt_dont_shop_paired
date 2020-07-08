class Pet < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :approx_age
  validates_presence_of :sex
  validates_presence_of :image

  belongs_to :shelter

  has_many :favorite_pets
  has_many :favorites, through: :favorite_pets

  def adoptable?
    if self.status == true
      "Adoptable"
    else
      "Pending Adoption"
    end
  end
end
