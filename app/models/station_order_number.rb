class StationOrderNumber < ApplicationRecord
  after_create :create_stops
  before_destroy :destroy_stops

  belongs_to :route, class_name: 'Route'
  belongs_to :station, class_name: 'Station'

  private

  def create_stops
    self.route.trains.each do |train|
      PassingTrain.create(train_id: train.id, station_id: self.station_id)
    end
  end

  def destroy_stops
    PassingTrain.where(station_id: self.station_id).destroy_all
  end

end
