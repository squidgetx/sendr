class ScoresheetsController < ApplicationController

  def index
    if (current_scoresheet.nil?)
      render_error(500, "No scoresheet found")
      return
    end
    @scoresheet = current_scoresheet
    @climbs = @scoresheet.climbs
    @routes = @scoresheet.comp.routes
  end

end
