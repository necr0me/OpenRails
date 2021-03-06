class Route < ApplicationRecord

  has_many :trains, dependent: :nullify
  has_many :station_order_numbers, -> { order(:order_number) }, dependent: :destroy
  has_many :stations, :through => :station_order_numbers

  def name
    "#{self.stations.first.name} - #{self.stations.last.name}"
  end

  def add_station(station_id)
    StationOrderNumber.create(route_id: self.id, station_id: station_id, order_number: self.stations.count+1)
  end

  def remove_station(station_id)
    StationOrderNumber.find_by(route_id: self.id, station_id: station_id).destroy
  end

  def stations_after(station_id)
    Station.where(id: self.station_order_numbers
                          .where("order_number > ?",
                                 self.station_order_numbers
                                     .find_by(station_id: station_id).order_number)
                          .map(&:station_id))
  end

end

