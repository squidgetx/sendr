class ClimbersController < ApplicationController

  before_action :find_climber, except: [:signin, :login]

  def new
  end
  
  def create
    @climber = Climber.new(climber_params)
    if @climber.save
      # success
    else
      # failure!
    end
  end

  def show

  end

  def edit
  end

  def update
    @climber = @climber.update(climber_params)
    if @climber
    else 
    end
  end

  def destroy
  end
  
  def login
    ccs = params[:ccs_id]
    if ccs.nil?
      render_error(500, "ccs id not found in query")
      return
    end

    ccs = ccs.to_i

    c = Climber.where("ccs_id = ?", ccs).first
    if c.nil?
      render_error(500, "CCS id #{ccs} not found");
      return
    end

    session[:climber_id] = c.id
    render_data("logged in as #{c.name}");
  end

  private

  def find_climber
    @climber = Climber.find(params[:id])
  end

  def climber_params
    params.require(:climber).permit(:id, :ccs_id, :college_id, :name)
  end

end
