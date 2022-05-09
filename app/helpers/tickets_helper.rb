module TicketsHelper
  def get_necessary_trains(params)
    trains = []
    starting_station = Station.find_by(name: params[:start])
    if starting_station.present?
      if params[:finish] == ""
        trains = Train.where(id: PassingTrain.where(station_id: starting_station.id).map(&:train_id))
      else
        ending_station = Station.find_by(name: params[:finish])
        if ending_station.present?
          trains_ids = PassingTrain.where(station_id: starting_station.id).map(&:train_id)
          trains = Train.where(id: PassingTrain.where(train_id: trains_ids)
                                               .and(PassingTrain.where(station_id: ending_station.id)
                                                                .and(PassingTrain.where.not(arrival_time: nil))).map(&:train_id))
        end
      end
    end
    trains
  end
end
