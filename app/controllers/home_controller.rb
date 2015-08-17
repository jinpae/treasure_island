class HomeController < ApplicationController
	def index
		@treasures = @q.result(distinct: true).order(:name).paginate(page: params[:page])

		@latest_treasures = Treasure.latest
		@popular_treasures = Treasure.popular
	end
end
