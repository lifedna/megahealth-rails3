class PhrsController < ApplicationController
  def index
    redirect_to phr_conditions_path(current_user.phrs.first) 
  end

  def new
    @phr = Phr.new
    @phrs = current_user.phrs
  end

  def create
    phr = Phr.create(params[:phr])
    unless phr.nil?
      flash[:notice] = "Health Record has been created."
      redirect_to phr_conditions_url(phr)
    end
  end

  def show
    @phr = Phr.find params[:id]
    redirect_to phr_conditions_url(@phr)
  end

  def edit
    @phr = Phr.find params[:id]
  end

  def update
    @phr = Phr.find params[:id]
    if @phr.update_attributes(params[:phr])
      flash[:notice] = "Health Record has been updated."
      redirect_to healthportal_url
    end  
  end

  def destroy
  end
end
