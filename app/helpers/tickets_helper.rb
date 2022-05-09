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
          Train.where(id: trains_ids).each do |train|
            stations_after = train.route.stations_after(starting_station.id).to_a
            if stations_after.include?(ending_station)
              stop = PassingTrain.find_by(train_id: train.id, station_id: ending_station.id)
              if stop.arrival_time.present?
                trains << train
              end
            end
          end
        end
      end
    end
    trains
  end
end
