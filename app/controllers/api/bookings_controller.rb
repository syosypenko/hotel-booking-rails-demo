module Api
  class BookingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :set_hotel, only: [:create]

    def create
      check_in = Date.parse(booking_params[:check_in])
      check_out = Date.parse(booking_params[:check_out])
      room = Room.find(booking_params[:room_id])

      booking = room.bookings.build(
        guest_name: booking_params[:guest_name],
        guest_email: booking_params[:guest_email],
        check_in: check_in,
        check_out: check_out,
        total_price: room.calculate_price(check_in, check_out)
      )

      if booking.save
        render json: {
          success: true,
          booking: {
            id: booking.id,
            room: room.name,
            guest_name: booking.guest_name,
            check_in: booking.check_in,
            check_out: booking.check_out,
            total_price: booking.total_price
          }
        }, status: :created
      else
        render json: {
          success: false,
          errors: booking.errors.full_messages
        }, status: :unprocessable_entity
      end
    rescue ArgumentError
      render json: { error: 'Invalid date format' }, status: :bad_request
    end

    private

    def booking_params
      params.require(:booking).permit(:room_id, :guest_name, :guest_email, :check_in, :check_out)
    end
  end
end
