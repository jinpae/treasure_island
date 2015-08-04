class UsersController < ApplicationController
	before_action :set_user

  def show
		@owned_treasures = @user.treasures.paginate(page: params[:page], per_page: 15)
  end

	private
		def set_user
			@user = User.friendly.find(params[:id])
		end
end
