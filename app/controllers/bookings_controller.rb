class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @room = @booking.room
  end
end
