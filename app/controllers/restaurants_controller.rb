class RestaurantsController < ApplicationController

  def show
    @rest = Restaurant.find_by(id: params["id"])
    cookies["rest_id"] = @rest.id
    
  end

  def index
    # @restaurants = Restaurant.all
    @restaurants = Restaurant.page(params["page"]).per(10)
  end

  def new
    # @rest = Restaurant.new
  end

  def edit
    if session["user_id"].blank?
      redirect_to "/", notice: "Please sign in first."
    end
    if User.find_by(id: session["user_id"]).admin == false
      redirect_to "/", notice: "Sorry, you must be an administrator to edit the restaurant information."
    end
    @rest = Restaurant.find_by(id: params["id"])
  end


  def create
    @rest = Restaurant.new
    @rest.name = params["name"]
    @rest.address = params["address"]
    @rest.table_number = params["table_number"]
    
    if @rest.save
      redirect_to "/restaurants/#{@rest.id}", notice: "Restaurant added!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      redirect_to "/", notice: "Record not saved."
    end
  end

  def update
    @rest = Restaurant.find_by(id: params["id"])
    @rest.name = params["name"]
    @rest.address = params["address"]
    @rest.table_number = params["table_number"]
    
    if @rest.save
      redirect_to "/restaurants/#{@rest.id}", notice: "Restaurant information updated!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      redirect_to "/", notice: "Editting not performed!"
    end
  end

  def destroy
    @rest = Restaurant.find_by(id: params["id"])
    @rest.delete
    redirect_to "/", notice: "Restaurant deleted."
  end
end