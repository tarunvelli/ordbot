class PanelController < ActionController::Base
  include SetResources

  before_action :authenticate_user!
  before_action :set_restaurants
end
