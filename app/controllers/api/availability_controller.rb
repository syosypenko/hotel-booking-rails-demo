module Api
  class AvailabilityController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :set_hotel, only: [:index]

    def index
      check_in = Date.parse(params[:check_in])
      check_out = Date.parse(params[:check_out])

      @hotel = Hotel.first
      availability = @hotel.rooms.map { |room|
        {
          room_id: room.id,
          name: room.name,
          price_per_night: room.price_per_night,
          available: room.available_on?(check_in, check_out),
          total_price: room.calculate_price(check_in, check_out)
        }
      }

      render json: availability
    rescue ArgumentError
      render json: { error: 'Invalid date format' }, status: :bad_request
    end
  end
end
