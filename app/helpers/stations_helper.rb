module StationsHelper

  def execute(params)
    c_ids = params[:station][:connected_stations].map(&:to_i)
    to_destroy = StationConnection.where(station_id: params[:station_id])
                                  .where.not(connected_station_id: c_ids)
                                  .or(StationConnection.where(connected_station_id: params[:station_id]).where.not(station_id: c_ids))

    puts "Not common: #{to_destroy.to_a}"
    destroy_connections(to_destroy)

    common_connections = StationConnection.where(station_id: params[:station_id]).where(connected_station_id: c_ids).select(:connected_station_id)
    common_connections = common_connections.to_a.map{|c| c.connected_station_id }

    puts "Array: common_connections - #{common_connections}"

    c_ids.reject!{|v| common_connections.include?(v)}
    puts "Station with id #{params[:station_id]} will get connections with: #{c_ids}"
    c_ids.each do |connection|
      create_connection(params[:station_id], connection)
    end
  end

  def remove_all_connections(station_id)
    StationConnection.where(station_id: station_id)
                                  .or(StationConnection.where(connected_station_id: station_id)).each do |c|
      c.destroy
    end
  end

  private

  def create_connection(station_id, connected_station_id)
    StationConnection.create(station_id: station_id,
                             connected_station_id: connected_station_id)
    StationConnection.create(station_id: connected_station_id,
                             connected_station_id: station_id)
  end

  def destroy_connections(to_destroy)
    to_destroy.each do |c|
      c.destroy
    end
  end
end
