require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.

  describe "index" do
    it "responds with success when there are many drivers saved" do
      # Arrange
      # Ensure that there is at least one Driver saved
      Driver.new(name: 'Kelly', vin: '567', available: true)
      Driver.new(name: 'Gene', vin: '1234', available: true)

      # Act
      get drivers_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no drivers saved" do
      # Arrange
      # Ensure that there are zero drivers saved
      
      # Act
      get drivers_path

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    
    it "responds with success when showing an existing valid driver" do
      # Arrange
      driver = Driver.new(id: 1, name: 'April', vin: '123', available: true)
      driver.save

      # Act
      get driver_path(1)

      # Assert
      must_respond_with :success
    end

    it "responds with 404 with an invalid driver id" do
      # Arrange
      # Act
      get driver_path('banana')

      # Assert
      must_respond_with :not_found
    end
  end

  describe "new" do
    it "responds with success" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      # Arrange
      # Set up the form data
      driver_info = {
        driver: {
          name: 'Leah',
          vin: '9090DIM',
          available: true,
        },
      }
      # Act-Assert
      # Ensure that there is a change of 1 in Driver.count
      expect {
        post drivers_path, params: driver_info
      }.must_differ "Driver.count", 1

      # Assert
      # Find the newly created Driver, and check that all its attributes match what was given in the form data
      new_driver = Driver.find_by(name: driver_info[:driver][:name])
      expect(new_driver.vin).must_equal driver_info[:driver][:vin]
      expect(new_driver.available).must_equal driver_info[:driver][:available]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(new_driver)
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Arrange
      # Set up the form data so that it violates Driver validations
      driver_info = {
        driver: {
          name: nil,
          vin: '9090DIM',
          available: true,
        },
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        post drivers_path, params: driver_info
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      # We are not redirecting, we are rendering the "new" form again and displaying errors - this is fine according to the testing directions

    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      # Arrange
      old_info = Driver.new(id: 1, name: 'April', vin: '123', available: true)
      old_info.save

      # Act
      get edit_driver_path(old_info)

      # Assert
      must_respond_with :success
    end

    it "responds with redirect when getting the edit page for a non-existing driver" do
      # Arrange
      id = 'banana'

      # Act
      get edit_driver_path(id)
      # Assert
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing driver with valid information accurately, and redirect" do
      # Arrange
      old_info = Driver.new(id: 1, name: 'April', vin: '123', available: true)
      old_info.save
      # Ensure there is an existing driver saved
      # Assign the existing driver's id to a local variable
      old_id = old_info.id
      
      # Set up the form data
      updated_info = {
        driver: {
          name: 'May',
          vin: '123456',
          available: true
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(old_info), params: updated_info
      }.wont_change "Driver.count"
      # Assert
      # Use the local variable of an existing driver's id to find the driver again, and check that its attributes are updated
      updated_driver = Driver.find_by(id: old_id)
      expect(updated_driver.name).must_equal updated_info[:driver][:name]
      expect(updated_driver.vin).must_equal updated_info[:driver][:vin]
      expect(updated_driver.available).must_equal updated_info[:driver][:available]

      # Check that the controller redirected the user
      must_respond_with :redirect
      must_redirect_to driver_path(updated_driver)
    end

    it "does not update any driver if given an invalid id, and responds with a 404" do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = 'banana'
      # Set up the form data
      updated_info = {
        driver: {
          name: 'May',
          vin: '123456',
          available: true
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(id: id), params: updated_info
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller gave back a 404
      must_respond_with :not_found
    end

    it "does not create a driver if the form data violates Driver validations, and responds with a redirect" do
      # Arrange
      # Ensure there is an existing driver saved
      driver = Driver.create(id: 1, name: 'Kay', vin: 'J8E6NN75309Y', available: true)
      # Assign the existing driver's id to a local variable
      id = driver.id
      # Set up the form data so that it violates Driver validations
      updated_info = {
        driver: {
          name: 'May',
          vin: nil,
          available: true
        }
      }

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        patch driver_path(id: id), params: updated_info
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller redirects
      # we are not redirecting, but re-rendering the form and displaying errors
    end
  end

  describe "destroy" do
    it "destroys the driver instance in db when driver exists, then redirects" do
      # Arrange
      # Ensure there is an existing driver saved
      driver_to_delete = Driver.create(id: 1, name: 'June', vin: '142536', available: true)
      # Act-Assert
      # Ensure that there is a change of -1 in Driver.count
      expect {
        delete driver_path(driver_to_delete)
      }.must_differ "Driver.count", -1
      # Assert
      # Check that the controller redirects
      must_respond_with :redirect
      must_redirect_to drivers_path
    end

    it "does not change the db when the driver does not exist, then responds with " do
      # Arrange
      # Ensure there is an invalid id that points to no driver
      id = 'taco'

      delete driver_path(id)

      # Act-Assert
      # Ensure that there is no change in Driver.count
      expect {
        delete driver_path(id: id)
      }.wont_change "Driver.count"

      # Assert
      # Check that the controller responds or redirects with whatever your group decides
      must_respond_with :not_found
    end
  end
end
