class CompsController < ApplicationController

  before_action :find_comp, except: [:index]

  def index
    # Homepage
    # If climber logged in with
    # active scoresheet,
    # redirect to scoresheet home
    if @current_scoresheet.present?
      redirect_to scoresheet_path
    end
    @comps = Comp.open
  end

  def show
    # this is where we see who are the top 3 in
    # each category
    @leaders = @comp.leaders
  end

  def new
  end

  def create
    @comp = Comp.new(comp_params)
    if @comp.save

    else

    end
  end

  def edit
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
      render_error(500, "Climber not logged in")
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
