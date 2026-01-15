class PagesController < ApplicationController
  def home
    @rooms = @hotel.rooms
  end
end
