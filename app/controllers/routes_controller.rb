class RoutesController < ApplicationController

  def index
    @routes = Route.all.includes(:stations).order(id: :ASC).paginate(page: params[:page], per_page: 7)
  end

  def show
    @route = Route.find(params[:id])
  end

  def new
    @route = Route.new
    @stations = Station.all
  end

  def create
    if params[:station_id].present?
      route = RouteCreator.new(station_id: params[:station_id]).call
      respond_to do |format|
        format.js { render js: "window.location = '#{routes_path}/#{route.id}/edit'"}
      end
    end
  end

  def edit
    @route = Route.find(params[:id])
    @connected_stations = NotCommonStationsFinder.new(stations_a: @route.stations.last.connected_stations,
                                                      stations_b: @route.stations).call
  end

  def update
    @route = Route.find(params[:id])
    RouteStationsManager.new(route: @route,
                             station_id: params[:route][:station_id],
                             action: params[:route][:action]).call
    respond_to do |format|
      if @route.stations.present?
        @stations = NotCommonStationsFinder.new(stations_a: @route.stations.last.connected_stations,
                                                stations_b: @route.stations).call
        format.js
      else
        format.js { render js: "window.location = '#{routes_path}'" }
      end
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy
    redirect_to request.referrer
  end

end
