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
    @review = Review.find(params[:id])
    if @review.update(review_params)
      @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter_id}"
    else
      flash[:alert] = "This is an invalid edit to a review! Please re-enter."
      render :edit
    end
  end

  def destroy
    @shelter_id = params[:shelter_id]
    Review.destroy(params[:id])
    redirect_to "/shelters/#{@shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
