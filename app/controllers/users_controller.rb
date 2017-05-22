class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params["id"])
    if @user.id != session["user_id"]
      redirect_to "/", notice: "Sorry, you cannot edit this account!"
    end
  end

  def show
    @user = User.find_by(id: params["id"])
    if @user.id != session["user_id"]
      redirect_to "/", notice: "Sorry, you cannot view this account!"
    end
  end

  def create
    @user = User.new
    @user.name = params["name"]
    @user.password = params["password"]
    @user.points = 0
    @user.email = params["email"]
    if @user.save
      redirect_to "/", notice: "Thanks for signing up!"
    else 
      # redirect_to "/users/new", notice: "Whoa, nice try!"
      redirect_to '/users/new', notice: "Signing up failed. Please try again."
    end
  end

  def update
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
  end


end