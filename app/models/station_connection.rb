class StationConnection < ApplicationRecord
  belongs_to :station, class_name: 'Station'
  belongs_to :connected_station, class_name: 'Station'
end
