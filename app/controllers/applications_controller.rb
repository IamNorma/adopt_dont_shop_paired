class ApplicationsController < ApplicationController
  def new
    @fav = favorites.contents.map do |id|
      Pet.all.find_all do |pet|
        pet.id == id
      end
    end.flatten
  end

  def create
    app = Application.new(application_params)
    if app.save
      flash[:notice] = "Application Submitted"
      redirect_to "/favorites"
      pets = []
      params[:pets].each do |pet_id|
        pets << Pet.find(pet_id)
      end
      pets.each do |pet|
        PetApplication.create(pet: pet, application: app)
        favorites.contents.delete(pet.id.to_i)
      end
    else
      flash[:alert] = "Application Not Submitted, Information Incomplete"
      redirect_to "/applications/new"
    end
  end

  def show
    @pets = Pet.joins(:applications).where("applications.id = ?", "#{params[:id]}")
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
