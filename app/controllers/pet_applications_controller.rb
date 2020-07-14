class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_app = PetApplication.where("pet_id = ?", params[:pet_id]).where("application_id = ?", params[:application_id])
    pet_app.first.status = true
    pet_app.first.save
    pet.status = false
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  private

  def pet_app_params
    params.permit(:status, :pet_id, :application_id)
  end
end
