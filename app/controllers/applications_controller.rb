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
      params[:pets].each do |pet_id|
        favorites.contents.delete(pet_id.to_i)
      end
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
