module TrainsHelper
  def update_stops(params)
    @train = Train.find(params[:id])
    if params[:train].has_key?(:stops)
      if @train.stops.count !=0
        params[:train][:stops].values.each do |stop|
          PassingTrain.find_by(station_id: stop[:station_id]).update(stop)
        end
      else
        params[:train][:stops].values.each do |stop|
          PassingTrain.create(train_id: params[:id],
                              station_id: stop[:station_id],
                              arrival_time: stop[:arrival_time],
                              departure_time: stop[:departure_time])
          end
      end
    elsif params[:train].has_key?(:route_id)
      @train.update(route_id: params[:train][:route_id])
      if @train.stops != nil
        @train.stops.destroy_all
      end
    end
  end
end
