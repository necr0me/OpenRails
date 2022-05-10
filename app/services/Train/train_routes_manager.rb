class TrainRoutesManager
  attr_reader :train_id, :route_id

  def initialize(train_id:, route_id:)
    @train_id = train_id
    @route_id = route_id
  end

  def call
    manage
  end

  private

  def manage
    @train = Train.find(@train_id)
    @train.update(route_id: @route_id)
    if @train.stops != nil
      @train.stops.destroy_all
    end
    @train.create_stops
    @train
  end
end
