class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    current_climber
  end

  def current_climber
    Climber.find(session[:climber_id]);
  end

  def current_scoresheet
    return nil if session[:scoresheet].nil?
    Scoresheet.find(session[:scoresheet])
  end

  def render_error(err, msg)
    render json: {
      error: err,
      message: msg
    }
  end

  def render_data(data)
    render json: {
      success: 1,
      data: data
    }
  end
end

