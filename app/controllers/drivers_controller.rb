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

    if @driver.save
      redirect_to driver_path(@driver.id)
      return
    else
      render :new
      return
    end

  end

  # def new
  #   if params[:author_id]
  #     # This is the nested route, /author/:author_id/books/new
  #     author = Author.find_by(id: params[:author_id])
  #     @book = author.books.new
  #   else
  #     # This is the 'regular' route, /books/new
  #     @book = Book.new
  #   end
  # end

  private
  def driver_params
    return params.require(:driver).permit(:id, :name, :vin, :available)
  end

end


