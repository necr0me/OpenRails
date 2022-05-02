class Carriage < ApplicationRecord
  belongs_to :carriage_type
  has_many :seats
end
