class TreasuresController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :set_treasure, except: [:index, :new, :create]

	def index
		if params[:tag]
			@treasures = Treasure.tagged_with(params[:tag])
		else
			@treasures = Treasure.all
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
		redirect_to :back
	end

	private
		def treasure_params
			params.require(:treasure).permit(:name, :url, :description, :tag_list)
		end

		def set_treasure
			@treasure = Treasure.find(params[:id])
		end
end
