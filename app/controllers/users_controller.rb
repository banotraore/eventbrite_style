class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show,:create,:edit,:update,:create,:destroy]
  before_action :is_my_profile, only: [:show,:edit]
  def show
    @user = User.find_by(id: params[:id])
    @event = Event.all
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
