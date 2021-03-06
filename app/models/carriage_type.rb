class CarriageType < ApplicationRecord
  has_many :carriages

  validates :name, presence: true, length: {minimum: 3, maximum: 32}
  validates :description, length: { maximum: 140}
  validates :capacity, presence: true, comparison: { greater_than_or_equal_to: 0}

end
