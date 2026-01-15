class Booking < ApplicationRecord
  belongs_to :room

  validates :guest_name, :guest_email, :check_in, :check_out, :total_price, presence: true
  validates :guest_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_out_after_check_in
  validate :room_available_for_dates

  private

  def check_out_after_check_in
    return unless check_in && check_out
    if check_out <= check_in
      errors.add(:check_out, 'must be after check_in')
    end
  end

  def room_available_for_dates
    return unless room && check_in && check_out
    
    # Check if room is available, excluding this booking if it's persisted
    overlapping_bookings = room.bookings.where.not(id: id).where('NOT (check_out <= ? OR check_in >= ?)', check_in, check_out)
    
    if overlapping_bookings.exists?
      errors.add(:base, 'Room is not available for the selected dates')
    end
  end
end
