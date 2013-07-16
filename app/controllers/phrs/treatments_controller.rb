class Phrs::TreatmentsController < ApplicationController
  def index
    @phr = Phr.find params[:phr_id]
    @treatments = @phr.treatments
  end

  def new
  end

  def create
    @phr = Phr.find params[:phr_id]
    if @phr.treatments.create(params[:treatment])
      flash[:notice] = "Treatment has been created."
      redirect_to mine_url(:phr => @phr)
    end 
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
