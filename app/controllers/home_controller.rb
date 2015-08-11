class HomeController < ApplicationController
	def index
		@treasures = @q.result(distinct: true).order(:name).paginate(page: params[:page])

		@recent_treasures = Treasure.recent
		@popular_treasures = Treasure.popular
	end
end
