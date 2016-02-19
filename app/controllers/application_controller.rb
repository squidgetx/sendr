class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_scoresheet

  def current_user
    current_climber
  end

  def current_climber
    return nil if session[:climber_id].nil?
    @current_climber = Climber.find_by_id(session[:climber_id]);
  end

  def current_scoresheet
    return nil if session[:scoresheet].nil?
    @current_scoresheet = Scoresheet.find_by_id(session[:scoresheet])
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

  def check_scoresheet
    return if current_climber.nil?
    return if current_scoresheet.nil?

    if @current_scoresheet.nil? || @current_scoresheet.comp.closed
      session[:scoresheet] = nil
    end
  end


end

