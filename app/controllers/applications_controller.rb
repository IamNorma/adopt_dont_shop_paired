class ApplicationsController < ApplicationController
  def new
    @fav = favorites.contents.map do |id|
      Pet.all.find_all do |pet|
        pet.id == id
      end
    end.flatten
  end
end
