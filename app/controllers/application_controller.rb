class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  auto_session_timeout 1.hour

  before_action :authenticate_user, :set_initial_week_day

  private
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
  	if !current_user
  		redirect_to new_session_path
    else
      $user_logged_to_logout = @current_user
    end
  end

  def only_admin
    if !current_user.is_admin?
      redirect_to calendar_events_path
    end
  end

  def commercial
    if !current_user.permission_commercial?
      redirect_to calendar_events_path
    end
  end

  def bidding
    if !current_user.permission_bidding?
      redirect_to calendar_events_path
    end
  end

  def juridical
    if !current_user.permission_juridical?
      redirect_to calendar_events_path
    end
  end

  def financial
    if !current_user.permission_financial?
      redirect_to calendar_events_path
    end
  end

  def partner
    if !current_user.permission_partner?
      redirect_to calendar_events_path
    end
  end

  def register
    if !current_user.permission_register?
      redirect_to calendar_events_path
    end
  end

  def report
    if !current_user.permission_report?
      redirect_to calendar_events_path
    end
  end
  
  def set_initial_week_day
    Date.beginning_of_week = :sunday
  end

end
