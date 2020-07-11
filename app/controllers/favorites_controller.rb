class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    quantity = favorites.count
    flash[:notice] = "You now have #{pluralize((quantity), "pet")} in your favorites!"
    redirect_to '/pets'
  end

  def index
    @favorited_pets = favorites.contents.map do |id|
      Pet.find(id)
    end
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    if favorites.contents.delete(pet.id)
      flash[:notice] = "You have removed this pet from your favorites"
      redirect_to "/pets/#{pet.id}"
    else
      redirect_to "favorites"
    end 
  end
end
