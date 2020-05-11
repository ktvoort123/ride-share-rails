class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def show
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end 

  def edit
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    end
  end

  def create
    passenger = Passenger.find_by(id: params[:passenger_id])
    if passenger.nil?
      head :not_found
      return
    else
      cost = Trip.trip_cost
      driver = Trip.assign_driver
      trip = Trip.new(driver_id: driver.id, passenger_id: passenger.id, date: Date.today, rating: nil, cost: cost)
      if trip.save
        redirect_to trip_path(trip.id)
        return
      else
        redirect_to passenger_path(passenger.id)
        return
      end
    end

  end

  def update
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @trip = Trip.find_by(id: params[:id])

    if @trip.nil?
      head :not_found
      return
    elsif @trip.destroy
      redirect_to root_path
      return
    else # to-do: what are we gonna do here huh
      render trip_path
      return
    end

  end

  # maybe we'll use this, and maybe we won't!
  def submit_rating
    @trip = Trip.find_by(id: params[:id])
    puts "trying to change rating"

    if @trip.nil?
      head :not_found
      return
    else
      @trip.rating(trip_params)
      trip.save
      redirect_to trip_path
    end
  end


  private
  def trip_params
    return params.require(:trip).permit(:id, :driver_id, :passenger_id, :date, :rating, :cost)
  end

end
