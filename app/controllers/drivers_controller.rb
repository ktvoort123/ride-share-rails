class DriversController < ApplicationController
  
  def index
    @drivers = Driver.all # maybe add: .order(:id)
  end
  
  def show
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    end
  end

  private
  def driver_params
    return params.require(:driver).permit(:id, :name, :vin, :available)
  end

end


