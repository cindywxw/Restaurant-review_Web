class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end


  def create
    @review = Review.new
    @review.content = params["content"]

    if @review.save
      redirect_to "/reviews/:id", notice: "Thanks for the review!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end
end