class PlotFamiliesController < ApplicationController
  def new
    @plot_family = PlotFamily.new
  end

  def create
    @plot_family = PlotFamily.new(params.require(:plot_family).permit(:name, :refresh_int_mins))
    @plot_family.save

    @plots = params[:plots]
    @plots.each { |i|
      s = PlotToFamily.new(:plot_id => i.to_i, :plot_family_id => @plot_family.id)
      s.save
    }
    redirect_to @plot_family
  end

  def show
    @plot_family = PlotFamily.find(params[:id])
  end

  def edit
    @plot_family = PlotFamily.find(params[:id])
  end

  def update
    @plot_family = PlotFamily.find(params[:id])
    @plot_family.update(params.require(:plot_family).permit(:name, :refresh_int_mins))
    @plot_family.plot_to_families.destroy_all

    @plots = params[:plots]
    @plots.each { |i|
      p = PlotToFamily.new(:plot_id => i.to_i, :plot_family_id => @plot_family.id)
      p.save
    }

    redirect_to @plot_family
  end

  def index
    @plot_families = PlotFamily.all
  end

  def destroy
   @plot_family = PlotFamily.find(params[:id])
   @plot_family.destroy

   redirect_to plot_families_path
  end
end
