class ClimbersController < ApplicationController

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
  
  def login
    ccs = params[:ccs_id].to_i
    if ccs.nil?
      render_error(500, "ccs id not found in query")
      return
    end

    c = Climber.where("ccs_id = ?", ccs).first
    if c.nil?
      render_error(500, "CCS id #{ccs} not found");
      return
    end
    session[:climber_id] = c.id
    render_data("logged in as #{c.name}");
  end

  private

  def climber_params
    params.require(:climber).permit(:id, :ccs_id, :college_id, :name)
  end

end
