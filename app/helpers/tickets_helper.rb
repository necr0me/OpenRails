module TicketsHelper
  def get_necessary_trains(params)
    trains = []
    starting_station = Station.find_by(name: params[:start])
    if starting_station.present?
      if params[:finish].present?
        ending_station = Station.find_by(name: params[:finish])
        if ending_station.present?
          trains_ids = []
          if params[:date].present?
            trains_ids = PassingTrain.where(station_id: starting_station.id)
                                     .and(PassingTrain.where("arrival_time > ?", DateTime.parse(params[:date]))).map(&:train_id)
          else
            trains_ids = PassingTrain.where(station_id: starting_station.id).map(&:train_id)
          end
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
      else
        if params[:date].present?
          trains = Train.where(id: PassingTrain.where(station_id: starting_station.id)
                                               .and(PassingTrain.where("arrival_time > ?", DateTime.parse(params[:date]))).map(&:train_id))
        else
          trains = Train.where(id: PassingTrain.where(station_id: starting_station.id).map(&:train_id))
        end
      end
    end
    trains
  end
end
