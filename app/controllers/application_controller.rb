class ApplicationController < ActionController::Base
  def signed_in_root_path(resource)
    home_path
  end
end
