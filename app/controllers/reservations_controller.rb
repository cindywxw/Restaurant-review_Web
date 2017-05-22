class ReservationsController < ApplicationController

  def index
    if session["user_id"].present?
      @reservations = Reservation.where(user_id: session["user_id"]).order("dine_at DESC")
      if User.find_by(id: session["user_id"]).admin == true
        @reservations = Reservation.all.order("dine_at DESC")
      end
    else
      redirect_to "/", notice: "Please log in first."
    end
    # @reservations = Reservation.where(user_id: cookies["user_id"]).order('dine_at desc')
  end

  def show
    if session["user_id"].present?
      @reservations = Reservation.where(user_id: session["user_id"]).order("dine_at DESC")
      if User.find_by(id: session["user_id"]).admin == true
        @reservations = Reservation.where(restaurant_id: cookies["rest_id"]).order("dine_at DESC")
      else
        redirect_to "/restaurants/", notice: "You are not allowed to view the reservations."
      end
    else
      redirect_to "/", notice: "Please log in first."
    end
    # @reservations = Reservation.where(user_id: cookies["user_id"]).order('dine_at desc')
  end

  def new
    if session["user_id"].present?
      # @reservation = Reservation.new
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."
    end
  end

  def create
    if session["user_id"].present?
      @reservation = Reservation.new
      @reservation.user_id = session["user_id"]
      @reservation.restaurant_id = cookies["rest_id"]
      @reservation.dine_at = params["dine_at"]
      @reservation.reserve_at = Time.now.utc.to_s(:db)
    
      if @reservation.save
        u = User.find_by(id: session["user_id"])
        newpoint = u.points + 10
        u.points = newpoint
        u.save(validate: false)
        redirect_to "/reservations", notice: "Thanks for your reservation! See you soon!"
      else
        redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Whoa, you forgot something. Please provide all your information."
      end
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."
    end
  end

  def destroy
    @reservation = Reservation.find_by(id: params["id"])
    @reservation.delete
    u = User.find_by(id: session["user_id"])
    newpoint = u.points - 10
    u.points = newpoint
    u.save(validate: false)
    redirect_to "/reservations", notice: "Reservation cancelled. We hope to see you again."
  end


end
