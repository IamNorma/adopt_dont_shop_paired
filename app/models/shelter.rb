class Shelter < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  has_many :pets
  has_many :reviews

  def pet_count
    self.pets.count
  end

  def average_review_rating
    self.reviews.average(:rating)
  end

  def application_count
    accum = []
    self.pets.each do |pet|
      accum << PetApplication.where("pet_id = ?", pet.id)
    end
    accum.flatten.count
  end
end
