class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	helper_method def logged_in?
	  !!current_user #double negation to convert to boolean
	end

	helper_method def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id] #memoized
	end
end
