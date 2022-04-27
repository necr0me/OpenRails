class StationsController < ApplicationController

  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:success]= "You have successfully created station."
      redirect_to stations_path
    else
      render 'new'
    end
  end

  def index
    @stations = Station.all.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @station = Station.find(params[:id])
  end

  def update

  end

  def destroy
    Station.find(params[:id]).destroy
    flash[:success] = 'Station deleted.'
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name)
  end

end
