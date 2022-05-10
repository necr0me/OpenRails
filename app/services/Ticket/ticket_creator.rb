class TicketCreator
  attr_reader :user_id, :seat_id, :departure_station_id, :destination_station_id

  def initialize(user_id:, seat_id:, departure_station_id:, destination_station_id:)
    @user_id = user_id
    @seat_id = seat_id
    @departure_station_id = departure_station_id
    @destination_station_id = destination_station_id
  end

  def call
    create_ticket
  end

  private

  def create_ticket
    @ticket = Ticket.create(user_id: @user_id,
                            seat_id: @seat_id,
                            departure_station_id: @departure_station_id,
                            destination_station_id: @destination_station_id)
    Seat.find(@ticket.seat_id).update(is_taken: true)
    @ticket
  end
end
