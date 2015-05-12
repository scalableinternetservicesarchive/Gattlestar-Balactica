class ErrorController < ActionController::Base
  #Controller to catch 404 errors from all unmatched routes
  def catch_404
    render '404'
  end
end