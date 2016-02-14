class ScoresheetsController < ApplicationController

  before_action :find_scoresheet

  def index
    @routes = @scoresheet.comp.routes
  end

  def climbs
    render json: @scoresheet.get_climbs
  end

  def speed
    @scoresheet.speed(params[:time])
  end

  def find_scoresheet
    @scoresheet = current_scoresheet
    if @scoresheet.nil?
      render_error(500, "No active scoresheet")
      return
    end
  end


end
