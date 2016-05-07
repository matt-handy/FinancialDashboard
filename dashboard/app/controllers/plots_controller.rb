class PlotsController < ApplicationController
  def new
    @plot = Plot.new
  end

  def create
    @plot = Plot.new(params.require(:plot).permit(:name, :days_duration))
    @plot.save

    @indicators = params[:indicators]
    @indicators.each { |i|
      s = Series.new(:indicator_id => i.to_i, :plot_id => @plot.id)
      s.save
    }
	@plot.regenerate_series
    redirect_to @plot
  end

  def show
    @plot = Plot.find(params[:id])
  end

  def edit
    @plot = Plot.find(params[:id])
  end

  def update
    @plot = Plot.find(params[:id])
    @plot.update(params.require(:plot).permit(:name, :days_duration))
    @plot.series.destroy_all

    @indicators = params[:indicators]
    @indicators.each { |i|
      s = Series.new(:indicator_id => i.to_i, :plot_id => @plot.id)
      s.save
    }
	@plot.regenerate_series
    redirect_to @plot
  end

  def index
    @plots = Plot.all
  end

  def destroy
   @plot = Plot.find(params[:id])
   @plot.series.destroy_all
   @plot.plot_to_families.destroy_all
   @plot.destroy

   redirect_to plots_path
  end
end
