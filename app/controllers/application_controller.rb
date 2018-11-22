class ApplicationController < ActionController::Base
  include Rectify::ControllerHelpers
  include CurrentOrder
  protect_from_forgery with: :exception

end
