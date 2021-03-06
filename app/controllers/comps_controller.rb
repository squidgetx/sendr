class CompsController < ApplicationController

  before_action :find_comp, except: [:index, :new, :create]

  def index
    # Homepage
    # If climber logged in with
    # active scoresheet,
    # redirect to scoresheet home
    if @current_scoresheet.present?
      redirect_to scoresheet_path
    end
    @comps = Comp.where("state = ? OR state = ?", 1, 2)
    @upcoming = Comp.closed.where("date >= ?", Date.today)
    @recent = Comp.closed.where("date < ?", Date.today)
  end

  def show
    # this is where we see who are the top 3 in
    # each category
  end

  def edit 
    @routes = @comp.routes.order(discipline: :asc, points: :desc)
  end

  def leaders
    render json: @comp.leaders
  end

  def new
    @comp = Comp.new
  end

  def create
    @comp = Comp.new(comp_params)
    if @comp.save
      redirect_to @comp
    else
      render 'new'
    end
  end

  def update
    @comp = @comp.update(comp_params)
    if @comp
    else
    end
  end

  def destroy
  end

  def start
    @comp.state = 'running'
    render json: @comp
  end
  
  def open
    @comp.state = 'open'
    render json: @comp
  end

  def close
    @comp.state = 'closed'
    render json: @comp
  end

  def join
    if current_climber.nil?
     # render_error(500, "Climber not logged in")
      redirect_to signin_climbers_path(comp: @comp.id)
      return
    end

    if (@comp.state == 'closed')
      render_error(500, "Comp not open")
      return
    end

    scoresheet = @comp.join(current_climber.id)
    session[:scoresheet] = scoresheet.id
    redirect_to '/scoresheet'
  end

  private

  def find_comp
    @comp = Comp.find(params[:id])
  end

  def comp_params
    params.require(:comp).permit(:id, :state, :location, :date)
  end

end
