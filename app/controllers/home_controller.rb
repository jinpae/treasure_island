class HomeController < ApplicationController
	def index
		if params[:q]
			@q = Treasure.search(params[:q].try(:merge, m: 'or').merge(tags_name_cont: params[:q].values[0]))
		else
			@q = Treasure.search(params[:q])
		end

		@treasures = @q.result(distinct: true).order(:name).paginate(page: params[:page])
	end
end
