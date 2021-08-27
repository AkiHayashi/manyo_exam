class ApplicationController < ActionController::Base
  before_action :basic

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['USER'] && password == ENV['PASS']
    end
  end
end