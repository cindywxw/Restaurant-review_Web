class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new
    @user.name = params["name"]
    @user.password = params["password"]
    @user.points = params["points"]
    @user.email_address = params["email_address"]
    if @user.save
      redirect_to "/", notice: "Thanks for signing up!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end
end