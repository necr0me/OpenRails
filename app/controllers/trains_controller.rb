class TrainsController < ApplicationController
  include TrainsHelper
  def index
    @trains = Train.all.includes(:route, :carriages).paginate(page: params[:page], per_page: 7)
  end

  def show
    @train = Train.find(params[:id])
  end

  def edit
    @train = Train.find(params[:id])
    @carriages = Carriage.where(train_id: nil)
  end

  def create
    Train.create
    redirect_to trains_path
  end

  def update
    puts params[:train]
    update_stops(params)

  end

  def destroy
    @train = Train.find(params[:id])
    @train.destroy
    redirect_to trains_path
  end

end
