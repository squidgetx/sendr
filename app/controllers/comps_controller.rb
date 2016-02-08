class CompsController < ApplicationController

  before_action :find_comp, except: [:index]

  def index
    # Homepage
    # If climber logged in with
    # active scoresheet,
    # redirect to scoresheet home
    if current_scoresheet.present?
      redirect to: scoresheets_index_path
    end
    @comps = Comp.open
  end

  def new
  end

  def create
  end

  def edit
  end
  
  def update
  end

  def destroy
  end

  def start
    @comp.state = 'running'
  end
  
  def open
    @comp.state = 'open'
  end

  def close
    @comp.state = 'closed'
  end

  def join
    if current_climber.nil?
      render_error(500, "Climber not logged in")
    end

    if (@comp.state == 'closed')
      render_error(500, "Comp not open")
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
