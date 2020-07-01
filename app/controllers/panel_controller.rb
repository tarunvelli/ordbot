class PanelController < ActionController::Base
  include InitResources

  before_action :authenticate_user!
  before_action :init_restaurants
end
