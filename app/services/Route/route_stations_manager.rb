class RouteStationsManager
  attr_reader :route, :station_id, :action

  def initialize(route:, station_id:, action:)
    @route = route
    @station_id = station_id
    @action = action
  end

  def call
    manage
  end

  private

  def manage
    if @action == 'add'
      if @station_id.present?
        @route.add_station(@station_id)
      end
    elsif @action == 'remove'
      @route.remove_station(@station_id)
    end
    if @route.stations.count == 0
      @route.destroy
    end
  end
end
