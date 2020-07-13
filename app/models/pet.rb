class Pet < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :approx_age
  validates_presence_of :sex
  validates_presence_of :image

  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def adoptable?
    if self.status == true
      "Adoptable"
    else
      "Pending Adoption"
    end
  end
end
