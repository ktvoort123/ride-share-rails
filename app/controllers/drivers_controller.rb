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

  def new
    @driver = Driver.new
    
  end

  # params[:driver_id]
  #     driver = Driver.find_by(id: params[:driver_id])
  #     @trip = driver.trips.new
  #   else

  def create
    @driver = Driver.new(driver_params)
    @driver.available = true

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return
    end

  end

  def edit
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    end
  end

  def update
    @driver = Driver.find_by(id: params[:id])

    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(driver_params)
      redirect_to driver_path
      return
    else 
      render :edit
      return
    end
    
  end
  
  def destroy
    driver = Driver.find_by(id: params[:id])

    if driver.nil?
      head :not_found
      return
    else
      driver.destroy
      redirect_to drivers_path
    end 
  end

  def mark_available
    driver = Driver.find_by(id: params[:id])
    if driver.nil?
      head :not_found
      return
    else
      driver.available = true
      driver.save
      redirect_to driver_path
      return
    end 
  end

  def mark_unavailable
    driver = Driver.find_by(id: params[:id])
    if driver.nil?
      head :not_found
      return
    else
      driver.available = false
      driver.save
      redirect_to driver_path
      return
    end 
  end

  private
  def driver_params
    return params.require(:driver).permit(:id, :name, :vin, :available)
  end

end


