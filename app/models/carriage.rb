class Carriage < ApplicationRecord
  belongs_to :carriage_type
  belongs_to :train
  has_many :seats, dependent: :destroy

  def capacity
    self.carriage_type.capacity
  end
end
