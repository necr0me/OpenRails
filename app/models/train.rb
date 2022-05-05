class Train < ApplicationRecord
  belongs_to :route, optional: true
  has_many :carriages, dependent: :nullify
  has_many :stops, -> {order(:arrival_time)}, class_name: 'PassingTrain', dependent: :destroy

  def destination
    self.route.name if self.route != nil
  end

end
