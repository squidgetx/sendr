class CompsController < ApplicationController

  before_action :find_comp

  def index
    # Homepage
    # If climber logged in with
    # active scoresheet,
    # redirect to scoresheet home
    if current_scoresheet.present?
      redirect to: scoresheets_index_path
    end
    @comps = JBuilder.new do |json|
      json.comps Comp.open
    end
    render json: @comps
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
    return nil if current_climber.nil?
    # return specific error codes for
    # closed comp and climber not logged in
    scoresheet = @comp.join(current_climber.id)
    session[:scoresheet] = scoresheet.id
  end

  private

  def find_comp
    @comp = Comp.find(comp_params[:id])
  end

  def comp_params
    params.require(:comp).permit(:id, :state, :location, :date)
  end

end
