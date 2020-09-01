class LandingpageController < ActionController::Base
  # TODO: replace with caches_page, requires actionpack-page_caching setup
  caches_action :index

  def index
  end
end
