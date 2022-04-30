class RoutesController < ApplicationController
  include RoutesHelper
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
    puts params
    unless params[:station_id].blank?
      route = create_route(params)
      respond_to do |format|
        format.js { render js: "window.location = '#{routes_path}/#{route.id}/edit'"}
      end
    end
  end

  def edit
    @route = Route.find(params[:id])
    @connected_stations = get_not_common_stations(@route.stations.last.connected_stations,
                                                  @route.stations)
  end

  def update
    @route = Route.find(params[:id])
    if params[:route][:action] == 'add'
      if params[:route][:station_id] != ''
        add_station(@route, params[:route][:station_id])
      end
    end
    @stations = get_not_common_stations(@route.stations.last.connected_stations,
                                        @route.stations)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @route = Route.find(params[:id])
    if @route.destroy
      flash[:success] = 'You have successfully deleted route.'
    else
      flash[:danger] = 'Something went wrong.'
    end
    redirect_to request.referrer
  end

end
