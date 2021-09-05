class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required
  private
  def login_required
    redirect_to new_session_path unless current_user
  end
  def already_logged_in
    redirect_to tasks_path if logged_in?
  end
  def ensure_current_user
    if current_user.id != params[:id].to_i && !current_user.admin? 
      flash[:notice]="権限がありません"
      redirect_to tasks_path
    end
  end
end