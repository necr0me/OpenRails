class Route < ApplicationRecord
  has_many :station_order_numbers, -> { order(:order_number) }, dependent: :destroy
  has_many :stations, :through => :station_order_numbers

  def name
    "#{self.stations.first.name} - #{self.stations.last.name}"
  end
end
