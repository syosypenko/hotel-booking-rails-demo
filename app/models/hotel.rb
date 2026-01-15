class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy

  validates :name, presence: true
  validates :currency, presence: true
end
