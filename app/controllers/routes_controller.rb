class RoutesController < ApplicationController
  before_action :find_route, except: [:index, :create]

  def index
  end

  def new
  end

  def create
    @route = Route.new(route_params)
    if @route.save
    else
    end
    redirect_to request.referer
  end

  def edit
  end

  def update
    @route = @route.update(route_params)
    if @route
    else
    end
    redirect_to request.referer
  end

  def destroy
  end

  def attemptClimb
    find_climb
    @climb.attempts += 1
    @climb.save
    render json: @climb
  end

  def sendClimb
    find_climb
    @climb.sent = true
    @climb.save
    @current_scoresheet.update_scores
    render json: @climb
  end

  def witnessClimb
    find_climb
    @climb.witness = params[:witness]
    @climb.sent = true
    @climb.save
    render json: @climb
  end

  private
  
  def route_params
    params.require(:route).permit(:name, :grade, :points, :comp_id, :location, :color, :notes, :discipline)
  end

  def find_route
    @route = Route.find(params[:id])
  end

  def find_climb
    # Find the current scoresheet
    @scoresheet = current_scoresheet
    return nil if @scoresheet.nil?

    @comp = @scoresheet.comp
    if (@comp.state == 'closed')
      render_error(500, "Competition is closed")
    end

    # Is there already an entry?
    @climb = Climb.where("scoresheet_id = ? AND route_id = ?", @scoresheet.id, @route.id).first
    if @climb.nil?
      @climb = Climb.create({
        route_id: @route.id,
        scoresheet_id: @scoresheet.id,
      })
    end
  end


end
