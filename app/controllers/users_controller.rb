class UsersController < ApplicationController
  def show
		@user = User.friendly.find(params[:id])
		@owned_treasures = @user.treasures.paginate(page: params[:page], per_page: 15)
  end
end
