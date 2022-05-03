class Train < ApplicationRecord
  belongs_to :route, optional: true
  has_many :carriages
  has_many :stops, class_name: 'PassingTrain', dependent: :destroy

end
