class ReviewsController < ApplicationController

  def new
    if session["user_id"].present?
      # @review = Review.new
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."      
    end
  end

  def create
    if session["user_id"].present?
      @review = Review.new
      @review.content = params["content"]
      @review.restaurant_id = cookies["rest_id"]
      @review.user_id = session["user_id"]
      @review.updated_at = Time.now.utc.to_s

      if @review.save
        redirect_to "/reviews/:id", notice: "Thanks for your review!"
      else 
        # redirect_to "/users/new", notice: "Whoa, nice try!"
        redirect_to "/reviews", notice: "Sorry ,review not created. #{@review.errors.full_message} Please try again."
      end
    else
      redirect_to "/", notice: "Please sign in first."
    end
  end

  def show
    if session["user_id"].present?
      @review = Review.find_by(id: params["id"])
      if session["user_id"] != @review.user_id
        redirect_to "/reviews/#{@review.id}", notice: "Sorry, you cannot edit this review."
      else 
        @rest = Restaurant.find_by(id: @review.restaurant_id)  
      end
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."
    end
  end

  def index
    # @restaurants = Restaurant.all
    if params["restaurant_id"] != nil
      @reviews = Review.where(restaurant_id: params["restaurant_id"]).order("updated_at DESC").page(params["page"]).per(10)
    elsif session["user_id"].present?
      @reviews = Review.where(user_id: session["user_id"]).order("updated_at DESC").page(params["page"]).per(10)
    else
      @reviews = Review.all.order("updated_at DESC").page(params["page"]).per(10)
    end

  end


  def edit
    if session["user_id"].blank?
      redirect_to "/", notice: "Please sign in first."
    else
      @review = Review.find_by(id: params["id"]) 
      if session["user_id"] != @review.user_id
        redirect_to "/reviews/#{@review.id}", notice: "Sorry, you cannot edit this review."
      end 
    end
  end


  def create
    @review = Review.new
    @review.content = params["content"]
    @review.restaurant_id = params["restaurant_id"]
    @review.user_id = session["user_id"]
    @review.updated_at = Time.now.utc.to_s
    
    if @review.save
      u = User.find_by(id: session["user_id"])
      newpoint = u.points + 10
      u.points = newpoint
      u.save(validate: false)
      redirect_to "/reviews/#{@review.id}", notice: "Thanks for your review!"
    else 
      render "/", notice: "Record not saved."
    end
  end

  def update
    @review = Review.find_by(id: params["id"])
    if session["user_id"] != @review.user_id
      redirect_to "/reviews/#{@review.id}", notice: "Sorry, you cannot edit this review."
    end 
    @review.content = params["content"]
    @review.updated_at = Time.now.utc.to_s
    
    if @review.save
      redirect_to "/reviews/#{@review.id}", notice: "Thanks for revising reviews!"
    else 
      render "/", notice: "Review not changed."
    end
  end

  def destroy
    if session["user_id"].blank?
      redirect_to "/", notice: "Please sign in first."
    else
      @review = Review.find_by(id: params["id"])
      if session["user_id"] != @review.user_id
        redirect_to "/reviews/#{@review.id}", notice: "Sorry, you cannot delete this review."
      else
      # notice: "Review deleted." 
        @review.delete
      end
    end  
  end

end