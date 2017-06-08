class ReservationsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index 
    if session["user_id"].present?
      @reservations = Reservation.where(user_id: session["user_id"]).order("dine_at DESC")
      if User.find_by(id: session["user_id"]).admin == true
        @reservations = Reservation.all.order("dine_at DESC")
        if params["restaurant_id"].present?
          @reservations = Reservation.where(restaurant_id: cookies["rest_id"]).order("dine_at DESC")
        end
      else
        if params["restaurant_id"].present?
          redirect_to "/reservations", notice: "Sorry, you are not authorized to view those reservations."
        end
      end 
      current = Time.current
      @pastReservation = @reservations.where(['dine_at < ?', current]).order("dine_at DESC")
      @futureReservation = @reservations.where(['dine_at > ?', current]).order("dine_at ASC")
    else
      redirect_to "/", notice: "Please log in first."
    end
  end

  def show
    if session["user_id"].present?
      @reservation = Reservation.find_by(id: params["id"])
      u = User.find_by(id: session["user_id"])
      if session["user_id"] != @reservation.user_id
        redirect_to "/restaurants/#{@reservation["restaurant_id"]}", notice: "Sorry, you cannot view this reservation."
      else 
        @rest = @reservation.restaurant  
      end
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."
    end
    # if session["user_id"].present?
    #   @reservations = Reservation.where(user_id: session["user_id"]).order("dine_at DESC")
    #   if User.find_by(id: session["user_id"]).admin == true
    #     @reservations = Reservation.where(restaurant_id: cookies["rest_id"]).order("dine_at DESC")
    #   else
    #     redirect_to "/restaurants/", notice: "You are not allowed to view the reservations."
    #   end
    # else
    #   redirect_to "/", notice: "Please log in first."
    # end
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
      @reservation.dine_at = @reservation.dine_at + 5.hours 
      @reservation.people = params["people"]
      @reservation.reserve_at = Time.current.utc.to_s(:db)
      
      if @reservation.save
        u = User.find_by(id: session["user_id"])
        newpoint = u.points + @reservation.people
        u.points = newpoint
        u.save(validate: false)
        redirect_to "/reservations/#{@reservation.id}", notice: "Thanks for your reservation! See you soon!"
      else
        redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Whoa, you forgot something.#{@reservation.errors.full_messages} Please provide all your information."
      end
    else
      redirect_to "/restaurants/#{cookies["rest_id"]}", notice: "Please sign in first."
    end
  end


  def destroy
    @reservation = Reservation.find_by(id: params["id"])
    @reservation.delete
    u = User.find_by(id: session["user_id"])
    newpoint = u.points - @reservation.people
    u.points = newpoint
    u.save(validate: false)
    redirect_to "/reservations", notice: "Reservation cancelled. We hope to see you again."
  end

end
