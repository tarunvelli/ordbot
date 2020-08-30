class PanelController < ActionController::Base
  include Pundit
  include SetResources

  before_action :authenticate_user!
  before_action :set_restaurants

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized(_exception)
    respond_to do |format|
      format.html { redirect_back(fallback_location: '/', notice: 'Access denied') }
      format.json { render json: { error: { message: 'Access denied' } }, status: :forbidden }
    end
  end
end
