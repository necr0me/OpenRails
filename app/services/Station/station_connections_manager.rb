class StationConnectionsManager
  attr_reader :station, :station_params

  def initialize(station:, station_params:)
    @station = station
    @station_params = station_params
  end

  def call
    manage
  end

  private
  def manage
    if @station_params.present?
      update_connections
    else
      @station.destroy_connections
    end
  end

  def update_connections
    c_ids = @station_params[:connected_stations].map(&:to_i)
    to_destroy = StationConnection.where(station_id: @station.id)
                                  .where.not(connected_station_id: c_ids)
                                  .or(StationConnection.where(connected_station_id: @station.id).where.not(station_id: c_ids))

    puts "Not common: #{to_destroy.to_a}"
    destroy_connections(to_destroy)

    common_connections = StationConnection.where(station_id: @station.id).where(connected_station_id: c_ids).select(:connected_station_id)
    common_connections = common_connections.to_a.map{|c| c.connected_station_id }

    puts "Array: common_connections - #{common_connections}"

    c_ids.reject!{|v| common_connections.include?(v)}
    puts "Station with id #{@station.id} will get connections with: #{c_ids}"
    c_ids.each do |connection|
      create_connection(@station.id, connection)
    end
  end

  def create_connection(station_id, connected_station_id)
    StationConnection.create(station_id: station_id,
                             connected_station_id: connected_station_id)
    StationConnection.create(station_id: connected_station_id,
                             connected_station_id: station_id)
  end

  def destroy_connections(to_destroy)
    to_destroy.destroy_all
  end

end
