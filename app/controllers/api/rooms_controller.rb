module Api
  class RoomsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :set_hotel, only: [:index]

    def index
      @hotel = Hotel.first
      @rooms = @hotel.rooms

      render json: @rooms.map { |room|
        {
          id: room.id,
          name: room.name,
          price_per_night: room.price_per_night,
          capacity: room.capacity
        }
      }
    end
  end
end
