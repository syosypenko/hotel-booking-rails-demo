class BookingsController < ApplicationController
  def index
    @bookings = Booking.all.order(created_at: :desc)
  end

  def show
    @booking = Booking.find(params[:id])
    @room = @booking.room
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking deleted successfully.'
  end
end
