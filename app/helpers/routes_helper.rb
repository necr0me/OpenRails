module RoutesHelper
  def create_route(params)
    route = Route.create
    StationOrderNumber.create(route_id: route.id, station_id: params[:station_id], order_number: route.stations.count+1)
    route
  end

  def add_station(route, station_id)
    StationOrderNumber.create(route_id: route.id, station_id: station_id, order_number: route.stations.count+1)
  end

  def remove_station(route, station_id)
    StationOrderNumber.find_by(route_id: route.id, station_id: station_id).destroy
  end

  def get_not_common_stations(stations_a, stations_b)
    res = []
    stations_a.each do |station_a|
      flag = false
      stations_b.each do |station_b|
        puts "#{station_a.id} compare with #{station_b.id}"
        if station_a.id == station_b.id
          flag = true
        end
      end
      res << station_a unless flag
    end
    res
  end
end

