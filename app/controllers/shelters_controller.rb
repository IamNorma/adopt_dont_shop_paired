class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      shelter.errors.full_messages.each do |error|
        flash[:alert] = error
      end
      redirect_to "/shelters/new"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      shelter.update(shelter_params)
      redirect_to "/shelters/#{shelter.id}"
    else
      shelter.errors.full_messages.each do |error|
        flash[:alert] = error
      end
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    applications = []
    applications = shelter.pets.flat_map do |pet|
      applications << PetApplication.where("pet_id = ?", pet.id)
    end.flatten
    applications.each do |app|
      app.destroy
    end
    shelter.pets.destroy_all
    shelter.reviews.destroy_all
    shelter.destroy
    redirect_to "/shelters"
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
