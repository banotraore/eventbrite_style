class EventsController < ApplicationController
  def index
    @event = Event.all
  end
  
  def new

  end
end
