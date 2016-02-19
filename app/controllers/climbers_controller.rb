class ClimbersController < ApplicationController

  before_action :find_climber, except: [:signin, :login, :create, :logout]

  def new
  end
  
  def create
    @climber = Climber.new(climber_params)
    if @climber.save
      # success
      login_climber climber_params[:ccs_id]
      if params[:comp_id].present?
        redirect_to join_comp_path(params[:comp_id]), method: :put
      else
        redirect_to climber_path(@climber)
      end
    else
      # failure!
      render_error(500, "error")
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
    if ccs.nil? || ccs.empty? || ccs.to_i == 0
      render_error(500, "form_error")
      return
    end

    ccs = ccs.to_i
    c = login_climber ccs
    return if c.nil?
    if params[:comp_id].present?
      #render action: :join, controller: :comp
      render_data(join_comp_path(params[:comp_id]))
      return
    end
    render_data(climber_path(c))
  end

  def signin
    @climber = Climber.new
    if params[:comp].present?
      @comp = params[:comp]
    end
  end

  def logout
    session[:climber_id] = nil
    redirect_to root_path
  end

  private

  def login_climber ccs
    c = Climber.where("ccs_id = ?", ccs).first
    if c.nil?
      render json: {"error": 502,
                    "message": "id_not_found",
                    "data": ccs
      }
      return nil
    end
    session[:climber_id] = c.id
    return c
  end


  def find_climber
    @climber = Climber.find(params[:id])
  end

  def climber_params
    params.require(:climber).permit(:id, :ccs_id, :college_id, :name)
  end

end
