module TrainsHelper
  def update_stops(params)
    @train = Train.find(params[:id])
    if params[:train].has_key?(:stops)
      params[:train][:stops].values.each do |stop|
        PassingTrain.find_by(station_id: stop[:station_id], train_id: params[:id]).update(stop)
      end
    elsif params[:train].has_key?(:route_id)
      @train.update(route_id: params[:train][:route_id])
      if @train.stops != nil
        @train.stops.destroy_all
      end
      @train.create_stops
    end
    @train
  end
end
