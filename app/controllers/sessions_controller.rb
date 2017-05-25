class SessionsController < ApplicationController

def new

end

def destroy
	if session["user_id"].blank?
		redirect_to "/", notice: "Not signed in yet!"
	else
		reset_session
		# cookies.delete("user_id")
		redirect_to "/", notice: "See ya!"
	end
end


def create
	user = User.find_by(name: params["name"])

	if user.present?
		# if user.password == params['password']
		if user.authenticate(params["password"])
			# sign in
			session["user_id"] = user.id
			redirect_to "/", notice: "Welcome back, #{user.name}!"
		else 
			redirect_to "/login", notice: "Nice try."
		end
	else
		redirect_to "/login", notice: "Nice try."
	end
end


end
