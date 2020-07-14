class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    app = Application.find(params[:application_id])
    redirect_to "/pets/#{pet.id}"
  end
end
