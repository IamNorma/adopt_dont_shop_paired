class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.create(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:alert] = "This is an invalid review! Please re-enter."
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    require "pry"; binding.pry
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
