class ApplicationController < ActionController::API
  before_action :authenticate!

  protected

  def authenticate!
    render json: { errors: "Not Authorized" }, status: :unauthorized unless current_user.present?
  end

  def current_user
    token = params[:access_token] || request.headers["Authorization"].try { |h| h.split("Bearer ").last  }
    if token
      @current_user ||= User.find_or_create_by! access_token: token
    end
  end
end
