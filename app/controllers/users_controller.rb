class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil mis à jour !"
      redirect_to @user

    else
      render 'edit'
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Connectez vous svp"
      redirect_to login_url
    end
  end
     # Confirme si c'est le bon utilisateur.
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

  end
