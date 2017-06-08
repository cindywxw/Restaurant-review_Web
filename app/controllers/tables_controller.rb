class TablesController < ApplicationController

  def new
    if session["user_id"].present? && User.find_by(id: session["user_id"]).admin == true
    else
      redirect_to "/restaurants/#{@rest.id}/edit", notice: "Please sign in first."
    end
  end


  def create
    @table = Table.new
    @rest = Restaurant.find_by(id: params["restaurant_id"])
    @table.restaurant_id = params["restaurant_id"]
    @table.capacity = params["capacity"]
    lastTable = Table.where(restaurant_id: params["restaurant_id"]).last
    @table.table_order = lastTable.table_order + 1
    if @table.save
      @rest.table_number = @rest.table_number + 1
      @rest.save
      redirect_to "/restaurants/#{@rest.id}/edit", notice: "Table added!"
    else 
      redirect_to "/restaurants/#{@rest.id}/edit", notice: "Table not added.#{@table.errors.full_messages}"
    end
  end


  def destroy
    @table = Table.find_by(id: params["id"])
    @rest = Restaurant.find_by(id: params["restaurant_id"])
    if @rest.table_number == 1
      redirect_to "/restaurants/#{@rest.id}", notice: "Only 1 table remained. Please delete the restaurant directly."
    
    else
      if @table.delete
        @rest.table_number = @rest.table_number - 1
        @rest.save
        redirect_to "/restaurants/#{@rest.id}/edit", notice: "Table deleted."
      else
        redirect_to "/restaurants/#{@rest.id}/edit", notice: "Table not deleted.#{@table.errors.full_messages}"
      end
    end
  end


end