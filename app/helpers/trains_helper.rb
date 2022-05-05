module TrainsHelper
  def update_stops(params)
    @train = Train.find(params[:id])
    if @train.stops.count !=0
      puts "Stops is not empty"
      params[:train][:stops].values.each do |stop|
        PassingTrain.find_by(station_id: stop[:station_id]).update(stop)
      end
    else
      puts "Params is empty"
      params[:train][:stops].values.each do |stop|
        PassingTrain.create(train_id: params[:id],
                            station_id: stop[:station_id],
                            arrival_time: stop[:arrival_time],
                            departure_time: stop[:departure_time])
      end
    end
  end


end
