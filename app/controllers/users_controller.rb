class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show,:create,:edit,:update,:create,:destroy]
  def show
    @user = User.find_by(id: params[:id])
    @event = Event.all
  end

  def index
    @user = User.all
  end

  private

  def authenticate_user
    #unless current_user
      if !user_signed_in? || current_user.id != params[:id].to_i

      flash[:danger] = "Please log in to perform this action."
      redirect_to :root

    end
  end
  
end
