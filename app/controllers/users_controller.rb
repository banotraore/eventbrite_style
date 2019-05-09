class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show,:create,:edit,:update,:create,:destroy]
  before_action :is_my_profile, only: [:show,:edit]
  def show
    @user = User.find_by(id: params[:id])
    @event = Event.all
  end

  def index
    @user = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(
      description: params[:description],
      first_name: params[:first_name],
      last_name: params[:last_name]
      )
      flash[:update_success] = " Le profil a bien été mis à jour !"
      redirect_to @user
    else
      flash[:update_warning] = " Le profil n'a pas pu être mis à jour !"
      redirect_to @user
    end

  end

  private

  def authenticate_user
    #unless current_user
      if !user_signed_in? || current_user.id != params[:id].to_i

      flash[:danger] = "Please log in to perform this action."
      redirect_to :root
    end
  end

  def is_my_profile
    unless current_user == User.find(params[:id])
      flash[:danger] = "Access denied"
      redirect_to :root
    end
  end
end
