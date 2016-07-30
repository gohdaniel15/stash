class SessionsController < ApplicationController
	def new
	end

	def create
		@user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || User.create_with_omniauth(auth_hash)
	  if @user
     session[:user_id] = @user.id
     redirect_to root_url
	  else
     redirect_to root_url
	  end
	end

	def destroy
		byebug
		session[:user_id] = nil
    redirect_to sign_in_path
	end

	protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
