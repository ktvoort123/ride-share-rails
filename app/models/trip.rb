class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger
  validates :date, presence: true
  validates :cost, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6, allow_nil: true }

  def self.trip_cost
    return rand(500..10000)
  end

  def self.assign_driver
    driver = Driver.all.select {|driver| driver.available == true }.sample
    driver.available = false
    driver.save
    return driver
  end
end
