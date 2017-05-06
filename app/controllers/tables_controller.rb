class AdministratorsController < ApplicationController

  def new
    @table = Table.new
  end


  def create
    @table = Table.new
    @table.capacity = params["capacity"]

    if @table.save
      redirect_to "/administrators", notice: "Table added!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      render 'signup'
    end
  end
end