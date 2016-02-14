class RoutesController < ApplicationController
  before_action :find_route, except: [:index]

  def index
  end

  def new
  end

  def create
    @route = Route.new(route_params)
    if @route.save
    else
    end
  end

  def edit
  end

  def update
    @route = @route.update(route_params)
    if @route
    else
    end
  end

  def destroy
  end

  def attempt
    find_climb
    @climb.attempts += 1
    @climb.save
    render json: @climb
  end

  def send
    find_climb
    @climb.sent = true
    @climb.save
    render json: @climb
  end

  def witness
    find_climb
    @climb.witness = params[:witness]
    @climb.sent = true
    @climb.save
    render json: @climb
  end

  private

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
