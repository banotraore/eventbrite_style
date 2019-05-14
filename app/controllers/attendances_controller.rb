class AttendancesController < ApplicationController

  before_action :authenticate_user, only: [:show ]

  def index
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances
  end

  def create
    @event = Event.find(params[:event_id])

    if @event.is_free?
      Attendance.create(user: current_user, event: @event)
      redirect_to @event
    else
      begin
      # Amount in cents
      @amount = @event.price
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount * 100,
        description: 'Rails Stripe customer',
        currency: 'eur'
      )

      Attendance.create(user: current_user, event: @event, stripe_customer_id: customer.id)
      flash[:success] = "You're now register to this event"
      rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to @event
    end
    end
  end

  def authenticate_user
    #unless current_user
      if !user_signed_in? || current_user.id != params[:id].to_i

      flash[:danger] = "Please log in to perform this action."
      redirect_to :root

    end
  end


end
