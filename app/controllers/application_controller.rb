class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash.now[:alert] = "Usted no está autorizado para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end
end
