class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_for_favorite

  private

  def check_for_favorite
    @favorite = Favorite.new
  end
end
