class HomeController < ActionController::Base
  layout "application"
  before_action :authenticate_user!

  def index
    console
  end
end
