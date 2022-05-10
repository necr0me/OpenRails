class TrainArrivalStationsFinder
  attr_reader :train, :departure_station

  def initialize(train:, departure_station:)
    @train = train
    @departure_station = departure_station
  end

  def call
    find_arrival_stations
  end

  private

  def find_arrival_stations
    stations_ids = Station.where(id: @train.route.station_order_numbers
                                           .where("order_number > ?",
                                                  @train.route.station_order_numbers
                                                        .find_by(station_id: @departure_station.id)
                                                        .order_number).map(&:station_id)).map(&:id)
    @train.stops.where(station_id: stations_ids).and(@train.stops.where.not(arrival_time: nil))
  end
end

