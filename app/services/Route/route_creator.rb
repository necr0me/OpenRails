class RouteCreator
  attr_reader :station_id

  def initialize(station_id:)
    @station_id = station_id
  end

  def call
    create_route
  end

  private

  def create_route
    route = Route.create
    route.add_station(station_id)
    route
  end
end
