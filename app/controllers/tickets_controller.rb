class TicketsController < ApplicationController

  def new
    @train = Train.find(params[:train_id])
    @departure_station = Station.find(params[:departure_station_id])
    @arrival_station = Station.find(params[:arrival_station_id])
  end

  def create
    puts params
    @seat = Seat.find(params[:ticket][:seat_id])
    if @seat.is_taken
      respond_to do |format|
        format.js
      end
    else
      TicketCreator.new(user_id: params[:ticket][:user_id],
                        seat_id: params[:ticket][:seat_id],
                        departure_station_id: params[:ticket][:departure_station_id],
                        destination_station_id: params[:ticket][:destination_station_id]).call
      # @ticket = Ticket.create(ticket_params)
      # @seat = Seat.find(params[:ticket][:seat_id]).update(is_taken: true)
      render js: "window.location = '#{user_path(current_user)}'"
    end
  end

  def index
    puts params
    @departure_station = Station.find_by(name: params[:start])
    @arrival_station = Station.find_by(name: params[:finish])
    @trains = TrainsFinder.new(
      start: params[:start],
      finish: params[:finish],
      date: params[:date]
    ).call
    puts @trains.to_a.inspect
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(ticket_params)
  end

  def destroy
    @ticket = Ticket.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit(:user_id, :seat_id, :departure_station_id, :destination_station_id)
  end
end
