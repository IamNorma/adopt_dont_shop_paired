class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_favorite_count

  private

  def find_favorite_count
    @favorite_count = Favorite.all.count
  end
end
