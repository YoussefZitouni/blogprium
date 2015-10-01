class UsersController < ApplicationController
  def new
  end
  # Fonction servant a voir les utilisateurs en servant de leur id like /users/1
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  # Fonction servant à l'inscription, si il y a une erreur ça passe dans le else qui fait une sorte de redirection vers le template new
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Bienvenue sur mon blog!"

      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation)
  end


end
