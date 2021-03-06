class Station < ApplicationRecord
  before_destroy :destroy_connections

  has_many :station_connections
  has_many :connected_stations, :through => :station_connections,
           source: :connected_station

  has_many :station_order_numbers, dependent: :destroy
  has_many :routes, :through => :station_order_numbers

  has_many :passing_trains, -> {order(:arrival_time)}, dependent: :destroy

  has_many :arrival_tickets, class_name: 'Ticket', foreign_key: :destination_station_id, dependent: :destroy
  has_many :departure_tickets, class_name: 'Ticket', foreign_key: :departure_station_id, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30, minimum: 1}

  def destroy_connections
    StationConnection.where(station_id: self.id)
                     .or(StationConnection.where(connected_station_id: self.id))
                     .destroy_all
  end

  def self.search(term)
    where("name LIKE :prefix", prefix: "#{term}%")
  end

end