class Station < ApplicationRecord
  before_destroy :destroy_connections

  has_many :station_connections
  has_many :connected_stations, :through => :station_connections,
           source: :connected_station

  has_many :station_order_numbers, dependent: :destroy
  has_many :routes, :through => :station_order_numbers

  has_many :passing_trains, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30, minimum: 1}

  def destroy_connections
    StationConnection.where(station_id: self.id)
                     .or(StationConnection.where(connected_station_id: self.id))
                     .destroy_all
  end
end