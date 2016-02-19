class ScoresheetsController < ApplicationController

  before_action :find_scoresheet

  def index
  end

  def scores
    render json: @scoresheet
  end

  def climbs
    render json: @scoresheet.get_climbs
  end

  def speed
    saved = @scoresheet.record_speed(params[:time])
    if saved
      render json: @scoresheet
    else
      render_error(500, "speed save failed")
    end
  end

  def submit
    session[:scoresheet] = nil
    redirect_to root_path
  end

  def find_scoresheet
    @scoresheet = current_scoresheet
    if @scoresheet.nil?
      render_error(500, "No active scoresheet")
      return
    end
  end


end
