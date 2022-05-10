class CarriagesController < ApplicationController
  before_action :admin_user, except: [:get_carriage]

  def new
    @carriage = Carriage.new
  end

  def create
    Carriage.create(carriage_type_id: params[:carriage_type])
    render js: "window.location = '#{carriages_path}'"
  end

  def show
    @carriage = Carriage.find(params[:id])
  end

  def get_carriage
    @carriage = Carriage.find(params[:carriage_id])
  end

  def update
    CarriageUpdater.new(carriage_id: params[:id],
                        train_id: params[:carriage][:train_id],
                        order_number: params[:carriage][:order_number]).call
    @train = Train.find(params[:train_id])
    @carriages = Carriage.where(train_id: nil)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @carriage = Carriage.find(params[:id])
    @carriage.destroy
    redirect_to carriages_path
  end

  def index
    @carriages = Carriage.all.includes(:carriage_type).paginate(page: params[:page], per_page: 7)
    @carriage_types = CarriageType.all
  end

  private

  def admin_user
    redirect_to root_path unless current_user_admin?
  end
end
