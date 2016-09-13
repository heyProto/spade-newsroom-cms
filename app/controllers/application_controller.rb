class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: :json_request?
  # protect_from_forgery with: :exception

  def json_request?
    ["*/*", "json"].include?(request.format)
  end
end
