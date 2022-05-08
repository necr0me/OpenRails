class Train < ApplicationRecord
  belongs_to :route, optional: true
  has_many :carriages, dependent: :nullify
  has_many :stops, -> {order(:arrival_time)}, class_name: 'PassingTrain', dependent: :destroy

  def destination
    self.route.name if self.route != nil
  end

  def arrival_time_at(station_id)
    self.stops.find_by(station_id: station_id).arrival_time if self.stops != nil
  end

  def departure_time_at(station_id)
    self.stops.find_by(station_id: station_id).departure_time if self.stops != nil
  end

end
