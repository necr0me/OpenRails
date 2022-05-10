class TrainsController < ApplicationController

  def index
    @trains = Train.all.includes(:route, :carriages).paginate(page: params[:page], per_page: 7)
  end

  def show
    @train = Train.find(params[:id])
  end

  def edit
    @train = Train.find(params[:id])
    @carriages = Carriage.where(train_id: nil)
    @routes = Route.all
  end

  def create
    Train.create
    redirect_to trains_path
  end

  def update
    if params[:train].has_key?(:stops)
      @train = TrainStopsManager.new(train_id: params[:id],
                                     stops: params[:train][:stops]).call
    elsif params[:train].has_key?(:route_id)
      @train = TrainRoutesManager.new(train_id: params[:id],
                                      route_id: params[:train][:route_id]).call
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @train = Train.find(params[:id])
    @train.destroy
    redirect_to trains_path
  end

  def get_arrival_stations
    @train = Train.find(params[:train_id])
    @departure_station = Station.find(params[:after])
    @stations = TrainArrivalStationsFinder.new(train: @train,
                                               departure_station: @departure_station).call
    respond_to do |format|
      format.js
    end
  end

end
