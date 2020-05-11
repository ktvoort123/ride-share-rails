require "test_helper"

describe TripsController do
  describe "show" do
    it 'responds with success when showing an existing valid trip' do 
      pass = Passenger.create(name: 'Joe', phone_num: '123-456-7890')
      driver = Driver.create(name: 'Kelly', vin: '567', available: true)
      trip = Trip.create(passenger_id: pass.id, driver_id: driver.id, date: Date.today, cost: 400, rating: nil)

      get trip_path(trip)

      must_respond_with :success
    end

    it 'responds with 404 with an invalid trip id' do
      get trip_path('banana')

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip with valid information accurately, and redirect" do
      pass = Passenger.create(name: 'Joe', phone_num: '123-456-7890')
      driver = Driver.create(name: 'Kelly', vin: '567', available: true)

      trip_info = {
        trip: {
          driver_id: driver.id,
          passenger_id: pass.id,
          date: Date.today,
          cost: nil,
          rating: nil
        }
      }

      expect {
        post passenger_trips_path(pass), params: trip_info
      }.must_differ "Trip.count", 1

      new_trip = Trip.find_by(passenger_id: trip_info[:trip][:passenger_id])
      expect(new_trip.date).must_equal trip_info[:trip][:date]
      expect(new_trip.cost).must_be_kind_of Integer
      expect(new_trip.rating).must_equal trip_info[:trip][:rating]
      expect(new_trip.driver_id).must_equal trip_info[:trip][:driver_id]

      must_respond_with :redirect
      must_redirect_to trip_path(new_trip)
    end

    it "does not create a trip if the data violates trip validation" do
      
      driver = Driver.create(name: 'Steven', vin: '33333', available: true)

      trip_info = {
        trip: {
          driver_id: driver.id,
          passenger_id: "banana",
          date: nil,
          cost: nil,
          rating: nil
        }
      }
      
      expect {
        post passenger_trips_path("banana"), params: trip_info
      }.wont_change "Trip.count"
      end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      pass = Passenger.create(name: 'Steve', phone_num: '123-7890')
      driver = Driver.create(name: 'Stephen', vin: '1234123', available: true)
      old_trip = Trip.create(passenger_id: pass.id, driver_id: driver.id, date: Date.today, cost: 70000, rating: nil)

      get edit_trip_path(old_trip)

      must_respond_with :success

    end

    it "responds with redirect when getting the edit page for a non-existing trip" do
      id = "hello"

      get edit_trip_path(id)

      must_respond_with :not_found
    end

  end

  describe "update" do

    it "can update an existing trip with valid information accurately, and redirect" do
      pass = Passenger.create(name: 'Kevin', phone_num: '555-7890')
      driver = Driver.create(name: 'Lauren', vin: '243434343', available: true)

      old_trip = Trip.create(passenger_id: pass.id, driver_id: driver.id, date: Date.today, cost: 15000, rating: nil)

      old_trip_id = old_trip.id

      updated_info = {
        trip: {
          passenger_id: pass.id, 
          driver_id: driver.id, 
          date: Date.today, 
          cost: 60000, 
          rating: 3
        }
      }
      expect { patch trip_path(old_trip), params: updated_info }.wont_change "Trip.count"

      updated_trip = Trip.find_by(id: old_trip_id)
      expect(updated_trip.passenger_id).must_equal updated_info[:trip][:passenger_id]
      expect(updated_trip.driver_id).must_equal updated_info[:trip][:driver_id]
      expect(updated_trip.date).must_equal updated_info[:trip][:date]
      expect(updated_trip.cost).must_equal updated_info[:trip][:cost]
      expect(updated_trip.rating).must_equal updated_info[:trip][:rating]

      must_respond_with :redirect
      must_redirect_to trip_path(updated_trip)

    end

    it "does not update any trips if given an invalid id, and responds with a 404" do
      
      bad_id = "not an id"

      pass = Passenger.create(name: 'Kevin', phone_num: '555-7890')
      driver = Driver.create(name: 'Lauren', vin: '243434343', available: true)

      updated_info = {
        trip: {
          passenger_id: pass.id, 
          driver_id: driver.id, 
          date: Date.today, 
          cost: 60000, 
          rating: 3
        }
      }

      expect { patch trip_path(id: bad_id), params: updated_info}.wont_change "Trip.count"

      must_respond_with :not_found
    
    end

    it "does not update a trip if the form data violates trip validations" do
      date = Date.today
      pass = Passenger.create(name: 'Ruth', phone_num: '555-343434')
      driver = Driver.create(name: 'Sally', vin: '2434444434343', available: true)
      trip = Trip.create(passenger_id: pass.id, driver_id: driver.id, date: date, cost: 33333, rating: nil)

      id = trip.id
     
      updated_info = {
        trip: {
          passenger_id: pass.id, 
          driver_id: driver.id, 
          date: nil, 
          cost: 33333, 
          rating: nil,
        }
      }

      expect { patch trip_path(id: id), params: updated_info}.wont_change "Trip.count"

      found_trip = Trip.find_by(id: id)
      expect(found_trip.date).must_equal date

    end
  end

  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      pass = Passenger.create(name: 'Dog', phone_num: '555-555555555')
      driver = Driver.create(name: 'Cat', vin: '9999999', available: true)
      trip_to_delete = Trip.create(passenger_id: pass.id, driver_id: driver.id, date: Date.today, cost: 12345, rating: nil)

      expect {delete trip_path(trip_to_delete)}.must_differ "Trip.count", -1
    end
    
    it "does not change the db when the trip does not exist, then responds with not found" do
      bad_id = "laskdfjasldfj"

      expect { delete trip_path(id: bad_id)}.wont_change "Trip.count"

      must_respond_with :not_found

    end

  end

end
