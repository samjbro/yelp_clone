class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user(review_params, current_user)

    if @review.save
      redirect_to restaurants_path
    else
      if @review.error[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  def destroy
    @review = Review.where(user_id: current_user.id, restaurant_id: params[:id].to_i)
    unless @review.empty?
      Review.destroy(@review.first.id)
      flash[:notice] = 'Review deleted successfully'
    else
      flash[:notice] = 'You cannot delete a review that you did not write'
    end
    redirect_to '/restaurants'
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
