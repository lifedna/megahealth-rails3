class PhrsController < ApplicationController
  def new
    @phr = Phr.new
  end

  def create
    if current_user.phrs.create(params[:phr])
      flash[:notice] = "Health Record has been created."
      redirect_to mine_url
    end
  end

  # def conditions
  #   @phr = Phr.find params[:id]
  #   @conditions = @phr.conditions
  # end

  # def symptoms
  #   @phr = Phr.find params[:id]
  # end

  # def treatments
  #   @phr = Phr.find params[:id]
  # end


  def update
    @phr = Phr.find params[:id]
    if @phr.update_attributes(params[:phr])
      flash[:notice] = "Health Record has been updated."
      redirect_to mine_url
    end  
  end

  def destroy
  end
end
