class SessionsController < ApplicationController
	def new
	end
	# Connecte l'utilisateur et le redirige vers la page show
	def create    
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			log_in user
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
			redirect_to user

		else
			# Créer un message d'erreur
			flash.now[:danger] = 'Invalide email/mot de passe'
			render 'new'
		end
	end
	# appelle l'helper log_out
	def destroy
		log_out if logged_in?
		redirect_to root_url
	end
end