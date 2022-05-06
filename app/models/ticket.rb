class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :seat
  belongs_to :arrival_station, class_name: 'Station'
  belongs_to :destination_station, class_name: 'Station'
end
