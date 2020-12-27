class HelpController < ActionController::Base
  # TODO: replace with caches_page, requires actionpack-page_caching setup
  caches_action :index

  def index; end

  def page
    render status: 404 unless lookup_context.find_all("help/pages/#{params[:page]}").any?

    render template: "help/pages/#{params[:page]}"
  end
end
