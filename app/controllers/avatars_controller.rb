class AvatarsController < ApplicationController
  def  create

    @event = Event.find(params[:event_id])
    if params[:avatar].nil?
      flash[:danger] = "We need a picture  !"
      redirect_to @event
    else
      @event.avatar.attach(params[:avatar])
      flash[:success] = "Picture updated !!"
      redirect_to @event

    end

  end
end
