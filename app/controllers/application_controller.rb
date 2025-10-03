class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActionController::RoutingError, with: :route_not_found

  def bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  def route_not_found(exception = nil)
    render json: { error: "Route not found" }, status: :not_found
  end
end