class UsersController < ApplicationController
	before_action :set_user

  def show
		@owned_treasures = @user.treasures.order(:name).paginate(page: params[:page], per_page: 15)
  end

	def hearted
		@hearted_treasures = @user.find_liked_items.sort_by { |t| t[:name] }

		current_page = params[:page] || 1
		per_page = 15
		total = @hearted_treasures.length

		@hearted_treasures = WillPaginate::Collection.create(current_page, per_page, total) do |pager|
			pager.replace(@hearted_treasures[pager.offset, pager.per_page].to_a)
		end
	end

	private
		def set_user
			@user = User.friendly.find(params[:id])
		end
end
