class ScoresheetController < ApplicationController

  def index
    if (current_scoresheet.nil?)
      render_error(500, "No scoresheet found")
    end
    render json: current_scoresheet.convert_json
  end

end
