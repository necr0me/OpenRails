class Station < ApplicationRecord
  has_many :station_connections, dependent: :destroy
  has_many :connected_stations, :through => :station_connections, source: :connected_station

  validates :name, presence: true, length: {maximum: 30, minimum: 1}
end
