class ApplicationController < ActionController::Base
  before_action :set_hotel

  private

  def set_hotel
    @hotel = Hotel.first || Hotel.create!(
      name: 'Grand Hotel',
      description: 'A luxurious hotel experience',
      address: '123 Main Street',
      currency: 'USD'
    )
  end
end
