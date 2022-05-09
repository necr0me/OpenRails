class Seat < ApplicationRecord
  belongs_to :carriage
  has_one :ticket, dependent: :destroy
end
