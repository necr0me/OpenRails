class Station < ApplicationRecord
  has_many :station_connections, dependent: :destroy
  has_many :connected_stations, :through => :station_connections, source: :connected_station
  has_many :station_order_numbers
  has_many :routes, :through => :station_order_numbers

  validates :name, presence: true, length: {maximum: 30, minimum: 1}
end
