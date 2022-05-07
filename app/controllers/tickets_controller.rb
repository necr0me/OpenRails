class TicketsController < ApplicationController

  def index
    puts params
    @departure_station = Station.find_by(name: params[:start])
    @arrival_station = Station.find_by(name: params[:finish])
    @trains = []
    if params[:finish] == ""
      @trains = PassingTrain.where(station_id: @departure_station.id)
    else
      if @arrival_station
      # @trains = PassingTrain.where(station_id: @departure_station.id)
      #                       .and(PassingTrain.where(train_id: PassingTrain.where(station_id: @arrival_station.id).select(:train_id).map(&:train_id)))
      #
      end
    end
    puts @trains.to_a.inspect
  end

  def create
    @ticket = Ticket.create(ticket_params)
  end

  def update
    @ticket = Ticket.find(params[:id])
    @ticket.update(ticket_params)
  end

  def destroy
    puts params
    @ticket = Ticket.find(params[:id])
  end

  private

  def ticket_params
    params.require(:ticket).permit(:user_id)
  end
end
