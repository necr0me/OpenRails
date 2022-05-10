class TrainStopsManager
  attr_reader :train_id, :stops

  def initialize(train_id:, stops:)
    @train_id = train_id
    @stops = stops
  end

  def call
    manage
  end

  private

  def manage
    @stops.values.each do |stop|
      PassingTrain.find_by(station_id: stop[:station_id], train_id: @train_id).update(stop)
    end
    Train.find(@train_id)
  end
end
