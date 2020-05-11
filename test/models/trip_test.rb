require "test_helper"

describe Trip do
  let (:driver) {
    Driver.create(name: "Kari", vin: "123", available: true)
  }
  let (:passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }
  let (:new_trip) {
    Trip.create(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: nil, cost: 3000)
  }

  it "can be instantiated" do
    expect(new_trip.valid?).must_equal true
  end

  it "will have the required fields" do
    new_trip.save
    trip = Trip.first
    [:driver_id, :passenger_id, :date, :rating, :cost].each do |field|

      expect(trip).must_respond_to field
    end
  end

  describe "relationships" do

  end

  describe "validations" do
    it 'must have a date' do
      new_trip.date = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end

    it 'must have a cost' do
      new_trip.cost = nil

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end

    it 'rating must be nil or between 1 and 5' do
      new_trip.rating = 100000000

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be less than 6"]
    end

    it 'rating must be nil or between 1 and 5' do
      new_trip.rating = -100000000

      expect(new_trip.valid?).must_equal false
      expect(new_trip.errors.messages).must_include :rating
      expect(new_trip.errors.messages[:rating]).must_equal ["must be greater than 0"]
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
