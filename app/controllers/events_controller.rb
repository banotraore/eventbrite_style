class EventsController < ApplicationController
  before_action :authenticate_user, only: [:create, :new, :edit]
   def index
     @events = Event.all
   end
   def show
     @event = Event.find(params[:id])
   end
   def new
     @event = Event.new
   end

   def create
     @event = Event.new(
      title:params[:title],
       description:params[:description],
       duration:params[:duration].to_i,
       start_date: DateTime.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i,
       params[:start_date][:hours].to_i,params[:start_date][:minutes].to_i),
       price:params[:price],
       location:params[:location].titleize,
       admin_id:current_user.id
      )
     if @event.save
       flash[:success] = "Event added to our list !"
       redirect_to @event
     else
       flash.now[:danger] = "Event not valid , missing parameters!"
       render :new
     end
   end

   def edit
     @event = Event.find(params[:id])
   end

   def update
     @event = Event.find(params[:id])
     if @event.update(
      title:params[:title],
       description:params[:description],
       duration:params[:duration].to_i,
       start_date: DateTime.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i,
       params[:start_date][:hours].to_i,params[:start_date][:minutes].to_i),
       price:params[:price],
       location:params[:location].titleize,
      )
       flash[:success] = "Event updated !"
       redirect_to @event
     else
       flash[:danger] = "Can't updatethis event!"
       render :edit
     end
   end

   def destroy
    @event.avatar.purge if @event.pictuavatarre.attached?
	
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to :root

  end

   private

   def authenticate_user
     unless current_user
       flash[:danger] = "You must be logged in to create an Event."
       redirect_to :root
     end
   end
end
