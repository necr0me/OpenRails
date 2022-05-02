class CarriagesController < ApplicationController
  def new
    @carriage = Carriage.new
  end

  def create
    puts params
    Carriage.create(carriage_type_id: params[:carriage_type])
    render js: "window.location = '#{carriages_path}'"
  end

  def edit
    @carriage = Carriage.find(params[:id])
  end

  def destroy
    @carriage = Carriage.find(params[:id])
    if @carriage.destroy
      flash[:success] = "Successfully deleted."
    else
      flash[:danger] = "Something went wrong."
    end
    redirect_to carriages_path
  end

  def index
    @carriages = Carriage.all.includes(:carriage_type).paginate(page: params[:page], per_page: 7)
    @carriage_types = CarriageType.all
  end
end
