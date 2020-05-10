class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    return self.trips.map { |trip| trip.cost }.sum
  end


end
