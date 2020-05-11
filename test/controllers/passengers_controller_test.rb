require "test_helper"

describe PassengersController do
  describe "index" do
    it "responds withsuccess when there are many passengers saved" do
      Passenger.create(name: 'Louie', phone_num: '248-123-1234')
      Passenger.create(name: 'Devin', phone_num: '567-123-1234')

      get passengers_path

      must_respond_with :success

    end

    it "responds with success when there are no passengers saved" do
      get passengers_path

      must_respond_with :success
    end

  end

  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      pass = Passenger.create(name: 'Joe', phone_num: '123-456-7890')
    
      get passenger_path(pass)

      must_respond_with :success

    end

    it "responds with 404 with an invalid passenger id" do
      get passenger_path("apple")
      must_respond_with :not_found
    end

  end

  describe "new" do
    it "responds with success" do
      get new_passenger_path

      must_respond_with :success

    end
  end

  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      passenger_info = {
        passenger: {
        name: 'John Smith',
        phone_num: '555.555.5555'
      },
    }

    expect { post passengers_path, params: passenger_info }.must_differ "Passenger.count", 1

    new_passenger = Passenger.find_by(name: passenger_info[:passenger][:name])

    expect(new_passenger.phone_num).must_equal passenger_info[:passenger][:phone_num]

    must_respond_with :redirect
    must_redirect_to passenger_path(new_passenger)

    end

    it "does not create a passsenger if the form data violates Passenger validation" do
      passenger_info = {
        passenger: {
        name: nil,
        phone_num: '123.555.5555'
      },
    }

    expect { post passengers_path, params: passenger_info }.wont_change "Passenger.count"
    end
  end

  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      old_info = Passenger.create(name: 'April', phone_num: '123')
      
      get edit_passenger_path(old_info)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing passenger" do
      id = 'banana'

      get edit_passenger_path(id)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do

      old_info = Passenger.create(name: 'April', phone_num: '456')

      old_id = old_info.id

      updated_info = {
        passenger: {
          name: 'June',
          phone_num: '789-098-9898'
        }
      }

      expect {
        patch passenger_path(old_info), params: updated_info
      }.wont_change "Passenger.count"

      updated_passenger = Passenger.find_by(id: old_id)
      expect(updated_passenger.name).must_equal updated_info[:passenger][:name]
      expect(updated_passenger.phone_num).must_equal updated_info[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passenger_path(updated_passenger)
    end

    it "does not update any passenger if given an invalid id, and responds with a 404" do

      id = 'banana'

      updated_info = {
        passenger: {
          name: 'Judy',
          phone_num: '8675309'
        }
      }

      expect {
        patch passenger_path(id: id), params: updated_info
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end

    it "does not create a passenger if the form data violates Passenger validations" do
      passenger = Passenger.create(name: 'Finnegan', phone_num: '456-1029')

      id = passenger.id

      updated_info = {
        passenger:  {
          name: 'Funnigan',
          phone_num: '123-9876'
        }
      }

      expect {
        patch passenger_path(id: id), params: updated_info
      }.wont_change "Passenger.count"
    end

  end

  describe "destroy" do
    it "destroys the passenger instance in db when driver exists, then redirects" do
      passenger_to_delete = Passenger.create(name: 'August', phone_num: '123')

      expect {
        delete passenger_path(passenger_to_delete)
      }.must_differ "Passenger.count", -1
    end

    it "does not change the db when the passenger does not exist, then responds with not found" do
      id = 'enchilada'

      expect {
        delete passenger_path(id: id)
      }.wont_change "Passenger.count"

      must_respond_with :not_found
    end
  end
end
