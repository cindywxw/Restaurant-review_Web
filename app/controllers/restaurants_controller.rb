class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def new
    @rest = Restaurant.new
  end

  def edit
    @rest = Restaurant.find_by(id: params["id"])
  end


  def create
    @rest = Restaurant.new
    @rest.name = params["name"]
    @rest.address = params["address"]
    @rest.table_number = params["table_number"]
    
    if @rest.save
      redirect_to "/", notice: "Table added!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end

  def update
    @rest = Restaurant.new
    @rest.name = params["name"]
    @rest.address = params["address"]
    @rest.table_number = params["table_number"]
    
    if @rest.save
      redirect_to "/", notice: "Table updated!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end
end