class Carriage < ApplicationRecord
  after_create :generate_name

  belongs_to :carriage_type
  belongs_to :train, optional: true
  has_many :seats, -> {order(:number)}, dependent: :destroy

  def capacity
    self.carriage_type.capacity
  end

  def create_seats
    for i in 1..self.capacity do
      Seat.create(carriage_id: self.id, number: i)
    end
  end

  private

  def generate_name
    self.update(name: "#{self.carriage_type.name}-" +
                    + "#{self.capacity}-#{self.id}-#{Date.current.year}")
  end
end
