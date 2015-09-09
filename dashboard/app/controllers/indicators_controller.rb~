class IndicatorsController < ApplicationController
  def new
    @indicator = Indicator.new
  end

  def create
    @indicator = Indicator.new(params.require(:indicator).permit(:name, :uri))
    @indicator.save
    redirect_to @indicator
  end

  def show
    @indicator = Indicator.find(params[:id])
  end

  def index
    @indicators = Indicator.all
  end

  def destroy
   @indicator = Indicator.find(params[:id])
   @indicator.destroy

   redirect_to indicators_path
  end
end
