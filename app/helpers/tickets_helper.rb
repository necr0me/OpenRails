module TicketsHelper
  def get_necessary_trains(params)
    trains = []
    starting_station = Station.find_by(name: params[:start])
    if params[:finish] == ""
      trains = Train.where(id: PassingTrain.where(station_id: starting_station.id).map(&:train_id))
    else
      ending_station = Station.find_by(name: params[:finish])
      if ending_station.present?
        trains_ids = PassingTrain.where(station_id: starting_station.id).map(&:train_id)
        trains = Train.where(id: PassingTrain.where(train_id: trains_ids).and(PassingTrain.where(station_id: ending_station.id)).map(&:train_id))
      end
    end
    trains
  end
end
