class PhrsController < ApplicationController
  def new
    @phr = Phr.new
  end

  def create
    if current_user.phrs.create(params[:phr])
      flash[:notice] = "Health Record has been created."
      redirect_to healthportal_url
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
