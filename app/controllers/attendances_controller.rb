class AttendancesController < ApplicationController
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
end
