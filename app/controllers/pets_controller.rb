class PetsController < ApplicationController
  def index
    @pets = Pet.all
    @shelters = Shelter.all
    @shelter_id = params[:shelter_id]
  end

  def show
    @pet = Pet.find(params[:id])
    temp_pet_app = PetApplication.where("pet_id = ?", params[:id]).where("status = ?", true)
    @pet_app = temp_pet_app.first
    @application = Application.find(@pet_app.application_id) if !@pet_app.nil?

  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    @shelter_id = params[:shelter_id]
    pet = shelter.pets.create(pet_params)
    if pet.save
      redirect_to "/shelters/#{@shelter_id}/pets"
    else
      flash[:notice] = shelter.pets.last.errors.full_messages.to_sentence
      redirect_to "/shelters/#{@shelter_id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    if pet.update(pet_params)
      redirect_to "/pets/#{pet.id}"
    else
      flash[:notice] = pet.errors.full_messages.to_sentence
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    destroy_pet = Pet.destroy(params[:id])
    favorites.contents.delete(destroy_pet.id)
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:name, :image, :approx_age, :sex, :shelter_name, :description, :status)
  end

end
