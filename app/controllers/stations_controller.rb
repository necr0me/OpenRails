class StationsController < ApplicationController
  include StationsHelper

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
    @stations = Station.search(params[:name]).order(id: :ASC).paginate(page: params[:page], per_page: 7)
  end

  def search_stations
    @stations = Station.search(params[:term])
    render json: @stations.map(&:name)
  end

  def show
    @station = Station.find(params[:id])
  end

  def edit
    @station = Station.find(params[:id])
    @stations = Station.where.not(id: params[:id])
  end

  def update
    @station = Station.find(params[:id])
    if @station.update(station_params)
      redirect_to stations_path
    else
      render 'edit'
    end
  end

  def update_station_connections
    puts params
    @station = Station.find(params[:station_id])
    if params.has_key?(:station)
      execute(params)
    else
      remove_all_connections(params[:station_id])
    end
    respond_to do |format|
      format.js
    end
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
