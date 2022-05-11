class Ticket < ApplicationRecord
  before_destroy :free_seat

  belongs_to :user
  belongs_to :seat
  belongs_to :departure_station, class_name: 'Station', optional: true
  belongs_to :destination_station, class_name: 'Station', optional: true

  def arrival_time
    PassingTrain.find_by(train_id: self.seat.carriage.train_id ,station_id: self.destination_station_id).arrival_time
  end

  def departure_time
    PassingTrain.find_by(train_id: self.seat.carriage.train_id ,station_id: self.departure_station_id).departure_time
  end

  private

  def free_seat
    self.seat.update(is_taken: false)
  end

end
