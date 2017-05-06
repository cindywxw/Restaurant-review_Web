class AdministratorsController < ApplicationController

  def new
    @admin = Administrator.new
  end


  def create
    @admin = Administrator.new
    @admin.name = params["name"]
    @admin.password = params["password"]

    if @admin.save
      redirect_to "/", notice: "Thanks for signing up!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end
end