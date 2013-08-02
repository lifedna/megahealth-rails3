class Phrs::ConditionsController < ApplicationController
  has_widgets do |root|
    root << widget('phr/condition', :condition)
  end

  def index
    @phr = Phr.find params[:phr_id]
    @conditions = @phr.conditions
    @phrs = @phr.user.phrs
  end

  def new
  end

  def create
    @phr = Phr.find params[:phr_id]
    if @phr.conditions.create(params[:condition])
      flash[:notice] = "Condition has been created."
      redirect_to phr_conditions_path(@phr)
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
