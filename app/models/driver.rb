class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true
  validates :vin, presence: true


  def total_earned
    return self.trips.map { |trip| 0.8 * (trip.cost - 1.65) }.sum
  end

  def average_rating
     trips_with_ratings = self.trips.select { |trip| trip.rating != nil }
     return ((trips_with_ratings.map { |trip| trip.rating }.sum)/trips_with_ratings.length.to_f).round(2)
  end

end
