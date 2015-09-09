class MainController < ApplicationController
  def hud
    @plot_family = PlotFamily.all.first
  end
end
