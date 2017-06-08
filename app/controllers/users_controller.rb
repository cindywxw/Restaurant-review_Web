class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    if session["user_id"].present?
      @user = User.find_by(id: params["id"])
      if @user == nil
        redirect_to "/", notice: "Sorry, you cannot edit this account!"
      elsif @user.id != session["user_id"]
          redirect_to "/", notice: "Sorry, you cannot edit this account!"
      end
    else
      redirect_to "/login", notice: "Sorry, you cannot edit this count. Please log in first."
    end
  end

  def show
    if session["user_id"].present?
      @user = User.find_by(id: params["id"])
      if @user == nil
        redirect_to "/", notice: "Sorry, you cannot view this account!"
      elsif @user.id != session["user_id"]
        redirect_to "/", notice: "Sorry, you cannot view this account!"
      end
    else
      redirect_to "/login", notice: "Sorry, you cannot view this count. Please log in first."
    end
  end

  def create
    @user = User.new
    @user.name = params["name"]
    @user.password = params["password"]
    @user.points = 0
    @user.email = params["email"]
    if @user.save
      reset_session
      redirect_to "/", notice: "Thanks for signing up!"
    else 
      redirect_to '/users/new', notice: "Signing up failed. Please try again."
    end
  end

  def update
    if session["user_id"].present?
      @user = User.find_by(id: params["id"])
      if @user.id != session["user_id"]
        redirect_to "/", notice: "Sorry, you cannot edit this account!"
      else
        if @user.authenticate(params["password"])
          @user.name = params["name"]
          @user.email = params["email"]
          change_pswd = params["changed_pswd"]
          if change_pswd == ""
            @user.password = params["password"]
          else
            @user.password = params["changed_pswd"]
          end

          if @user.save
            redirect_to "/users/#{@user.id}", notice: "Change saved."
          else
            redirect_to "/users/#{@user.id}/edit", notice: "Changed not saved.#{@user.errors.full_messages} Please try again."
          end
        else
          redirect_to "/users/#{@user.id}/edit", notice: "Password doesn't match. Please try again."
        end
      end
    else
      redirect_to "/login", notice: "Sorry, you cannot edit this count. Please log in first."  
    end
  end


end