class NotCommonStationsFinder
  attr_reader :stations_a, :stations_b

  def initialize(stations_a:, stations_b:)
    @stations_a = stations_a
    @stations_b = stations_b
  end

  def call
    get_not_common_stations
  end

  private

  def get_not_common_stations
    res = []
    @stations_a.each do |station_a|
      flag = false
      @stations_b.each do |station_b|
        if station_a.id == station_b.id
          flag = true
        end
      end
      res << station_a unless flag
    end
    res
  end
end
