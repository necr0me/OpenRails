class StationOrderNumber < ApplicationRecord
  belongs_to :route, class_name: 'Route'
  belongs_to :station, class_name: 'Station'
end
