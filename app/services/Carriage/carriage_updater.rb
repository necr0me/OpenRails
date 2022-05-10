class CarriageUpdater
  attr_reader :carriage_id,:train_id, :order_number

  def initialize(carriage_id:,train_id:, order_number:)
    @carriage_id = carriage_id
    @train_id = train_id
    @order_number = order_number
  end

  def call
    update_carriage
  end

  private

  def update_carriage
    carriage = Carriage.find(@carriage_id)
    carriage.update(train_id: @train_id,
                    order_number: @order_number)
    if carriage.train_id.nil?
      carriage.seats.destroy_all
    else
      carriage.create_seats
    end
  end
end
