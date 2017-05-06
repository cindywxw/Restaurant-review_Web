class ReservationsController < ApplicationController

  def index
    @reservations = Reservation.where(user_id: cookies["user_id"])
    # @reservations = Reservation.where(user_id: cookies["user_id"]).order('dine_at desc')
  end

  def new

  end

  def create
    @reservation = Reservation.new
    @reservation.user_id = cookies["user_id"]
    @reservation.restaurant_id = params["flight_id"]
    
    if @reservation.save
      redirect_to "/reservations"
    else
      redirect_to "/", notice: "Whoa, you forgot something"
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params["id"])
    @reservation.delete
    redirect_to "/reservations"
  end


end
