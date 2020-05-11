class Passenger < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :phone_num, presence: true

  def total_spent
    return self.trips.map { |trip| trip.cost/100.0 }.sum
  end


end
