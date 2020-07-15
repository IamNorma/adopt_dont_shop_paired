class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def adoptable?

    if status
      "Pending Adoption"
    else
      "Adoptable"
    end
  end
end
