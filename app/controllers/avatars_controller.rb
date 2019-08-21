class AvatarsController < ApplicationController
  def  create

    @event = Event.find(params[:event_id])
    if params[:avatar].nil?
      flash[:danger] = "We need a picture  !"
      redirect_to "root"
    else
      @event.avatar.attach(params[:avatar])
      flash[:success] = "Picture updated !!"
      redirect_to "root"

    end

  end
end
