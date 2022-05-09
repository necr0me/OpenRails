class TrainsController < ApplicationController
  include TrainsHelper

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
    puts params
    @train = update_stops(params)
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
    puts params
    @train = Train.find(params[:train_id])
    @departure_station = Station.find(params[:after])
    stations_ids = Station.where(id: @train.route.station_order_numbers
                                        .where("order_number > ?",
                                               @train.route.station_order_numbers
                                                     .find_by(station_id: @departure_station.id)
                                                     .order_number).map(&:station_id)).map(&:id)
    @stations = @train.stops.where(station_id: stations_ids).and(@train.stops.where.not(arrival_time: nil))
    puts @stations.to_a.inspect
    respond_to do |format|
      format.js
    end
  end

end
