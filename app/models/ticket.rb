class Ticket < ApplicationRecord
  before_destroy :free_seat

  belongs_to :user
  belongs_to :seat
  belongs_to :arrival_station, class_name: 'Station', optional: true
  belongs_to :destination_station, class_name: 'Station', optional: true

  private

  def free_seat
    self.seat.update(is_taken: false)
  end
end
