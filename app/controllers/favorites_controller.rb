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
end
