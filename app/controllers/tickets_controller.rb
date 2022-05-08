class TicketsController < ApplicationController

  def new
    puts params
    @train = Train.find(params[:train_id])
  end

  def create
    @seat = Seat.find(params[:ticket][:seat_id])
    if @seat.is_taken
      respond_to do |format|
        format.js
      end
    else
      @ticket = Ticket.create(ticket_params)
      @seat = Seat.find(params[:ticket][:seat_id]).update(is_taken: true)
      render js: "window.location = '#{user_path(current_user)}'"
    end

  end

  def index
    puts params
    @departure_station = Station.find_by(name: params[:start])
    @arrival_station = Station.find_by(name: params[:finish])
    @trains = []
    if params[:finish] == ""
      @trains = PassingTrain.where(station_id: @departure_station.id)
    else
      if @arrival_station
      @trains = PassingTrain.where(station_id: @departure_station.id)
                            .and(PassingTrain.where(train_id: PassingTrain.where(station_id: @arrival_station.id).select(:train_id).map(&:train_id)))
      end
    end
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
    params.require(:ticket).permit(:user_id, :seat_id)
  end
end
