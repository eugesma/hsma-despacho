class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash.now[:alert] = "Usted no está autorizado para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end
end
