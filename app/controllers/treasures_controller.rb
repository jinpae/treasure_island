class TreasuresController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :recent, :popular]
	before_action :require_correct_user, only: [:edit, :update, :destroy]
	before_action :set_treasure, only: [:show, :heart]

	def index
		if params[:tag]
			@treasures = Treasure.tagged_with(params[:tag]).order(:name).paginate(page: params[:page])
		elsif params[:letter]
			@treasures = Treasure.by_letter(params[:letter]).order(:name).paginate(page: params[:page])
		else
			@treasures = @q.result(distinct: true).order(:name).paginate(page: params[:page])
		end
	end

	def new
		@treasure = Treasure.new
	end

	def create
		@treasure = current_user.treasures.new(treasure_params)

		if @treasure.save
			redirect_to @treasure, notice: "New treasure submitted successfully."
		else
			render :new
		end
	end

	def show
		if request.path != treasure_path(@treasure)
			redirect_to @treasure, status: :moved_permanently
		end
	end

	def edit
	end

	def update
		if @treasure.update(treasure_params)
			redirect_to @treasure, notice: "Treasure updated successfully."
		else
			render :edit
		end
	end

	def destroy
		@treasure.destroy
		redirect_to root_path, notice: "Treasure deleted successfully."
	end

	def heart
		current_user.toggle_heart(@treasure)

		respond_to do |format|
			format.html { redirect_to @treasure }
			format.js
		end
	end

	# TODO: Clean up and refactor the code.
	def autocomplete_tags
		@tags = ActsAsTaggableOn::Tag.where("name LIKE ?", "#{params[:q]}%").order(:name)

		respond_to do |format|
			format.json do
				render json: @tags.collect { |t| { id: t.name, name: t.name } }
			end
		end
	end

	def recent
		@treasures = Treasure.recent(nil).paginate(page: params[:page])
		render :index
	end

	def popular
		@treasures = Treasure.popular(nil).paginate(page: params[:page])
		render :index
	end

	private
		def treasure_params
			params.require(:treasure).permit(:name, :url, :description, :tag_list)
		end

		def set_treasure
			@treasure = Treasure.friendly.find(params[:id])
		end

		def require_correct_user
			set_treasure
			current_user? @treasure.user
		end
end
