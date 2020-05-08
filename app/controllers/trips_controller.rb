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


  private
  def trip_params
    return params.require(:trip).permit(:id, :driver_id, :passenger_id, :date, :rating, :cost)
  end

end
