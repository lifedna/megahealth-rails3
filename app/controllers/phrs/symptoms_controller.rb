class Phrs::SymptomsController < ApplicationController
  has_widgets do |root|
    root << widget('phr/symptom', :symptom)
  end

  def index
    @phr = Phr.find params[:phr_id]
    @symptoms = @phr.symptoms
  end

  def new
  end

  def create
    @phr = Phr.find params[:phr_id]
    if @phr.symptoms.create(params[:symptom])
      flash[:notice] = "Symptom has been created."
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
