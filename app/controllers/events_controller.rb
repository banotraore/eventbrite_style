class EventsController < ApplicationController
  before_action :authenticate_user, only: [:create, :new]
   def index
     @event = Event.all
   end
   def show
     @event = Event.find(params[:id])
     @event_end = @event.start_date + (@event.duration*60)
   end
   def new
   end
   def create

     @event = Event.new(


      title:params[:title],
       description:params[:description],
       duration:params[:duration].to_i,
       start_date:Time.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i,
       params[:start_date][:hours].to_i,params[:start_date][:minutes].to_i),
       price:params[:price].to_i,
       location:params[:location],
       admin:current_user
     )
     if @event.save
       flash[:success] = "Event added !"
       redirect_to :root
     else
       flash[:danger] = "Event not valid !"
       render :new
     end
   end




   private

   def authenticate_user
     unless current_user
       flash[:danger] = "You must be logged in to create an Event."
       redirect_to :root
     end
   end
end
