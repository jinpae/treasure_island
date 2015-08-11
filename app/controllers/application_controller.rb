class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_q

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	private
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up).concat([:first_name, :last_name, :username])
			devise_parameter_sanitizer.for(:account_update).concat([:first_name, :last_name, :username])
		end

		def set_q
			if params[:q]
				@q = Treasure.search(params[:q].try(:merge, m: 'or').merge(tags_name_cont: params[:q].values[0]))
			else
				@q = Treasure.search(params[:q])
			end
		end

		def current_user?(user)
			current_user == user
		end

		helper_method :current_user?
end
