class ShelterPetsController < ApplicationController
  def index
    @shelter_id = params[:shelter_id]
    @pets = Pet.all.find_all do |pet|
      pet.shelter_id == @shelter_id.to_i
    end
    @shelter = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

end
