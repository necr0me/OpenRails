class TrainsFinder
    attr_reader :start, :finish, :date

    def initialize(start:, finish:, date: )
      @start = start
      @finish = finish
      @date = date
    end

    def call
      find_trains
    end

    private

    def find_trains
      trains = []
      starting_station = Station.find_by(name: @start)
      if starting_station.present?
        if @finish.present?
          ending_station = Station.find_by(name: @finish)
          if ending_station.present?
            if @date.present?
              trains_ids = PassingTrain.where(station_id: starting_station.id)
                                       .and(PassingTrain.where("arrival_time > ?", DateTime.parse(@date))) .map(&:train_id)
            else
              trains_ids = PassingTrain.where(station_id: starting_station.id).map(&:train_id)
            end
            Train.where(id: trains_ids).each do |train|
              stations_after = train.route.stations_after(starting_station.id).to_a
              if stations_after.include?(ending_station)
                puts "train - #{train.id}, station - #{ending_station.name}"
                stop = PassingTrain.find_by(train_id: train.id, station_id: ending_station.id)
                if stop.arrival_time.present? && train.carriages.count != 0
                  trains << train
                end
              end
            end
          end
        else
          if @date.present?
            trains = Train.where(id: PassingTrain.where(station_id: starting_station.id)
                                                 .and(PassingTrain.where("arrival_time > ?", DateTime.parse(@date))).map(&:train_id))
                          .joins(:carriages).group('trains.id').having("count(train_id) > 0")
          else
            trains = Train.where(id: PassingTrain.where(station_id: starting_station.id).map(&:train_id))
                          .joins(:carriages).group('trains.id').having("count(train_id) > 0")
          end
        end
      end
      trains
    end

end
