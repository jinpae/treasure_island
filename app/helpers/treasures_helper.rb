module TreasuresHelper
	def tag_link_to(treasure)
		treasure.tag_list.map do |tag|
			# tag is a string, representing current tag in the array
			link_to tag, tag_path(tag), class: "tag"
		end.join(", ").html_safe
	end

	def search_result_title
		# If user either searched via search form or by clicking a tag link,
		# display the title with the keyword or the tag name
		tag = params[:tag]
		search_keyword = params[:q]

		if tag || (search_keyword && search_keyword.values[0].present?)
			title = "Displaying results for #{content_tag :span, (tag || search_keyword.values[0])}".html_safe
		else
			if current_page? recent_treasures_path
				title = "Recent treasures"
			elsif
				current_page? popular_treasures_path
				title = "Popular treasures"
			else
				title = "Treasures"
			end
		end

		title
	end

	def letters
		@letters ||= Treasure.letter_indices
	end

	def heart_link_css
		if user_signed_in?
			current_user.hearted?(@treasure) ? 'hearted' : nil
		end
	end

	def truncate_description(description, options={})
		(current_page? root_path) ?
			truncate(description, options) : description
	end

	def link_to_actions(treasure)
		if current_user? treasure.user
			content_tag :span do
				link = link_to edit_treasure_path(treasure), class: "edit" do
					content_tag :i, nil, class: "fa fa-pencil"
				end

				link += link_to treasure, method: :delete, data: { confirm: "Are you sure you want to delete this treasure? (You cannot undo this action)" }, class: "delete" do
						content_tag :i, nil, class: "fa fa-trash"
				end
			end
		end
	end

	def markdown(content)
		context = {
			gfm: true,
			asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons'
		}

		pipeline = HTML::Pipeline.new [
			HTML::Pipeline::MarkdownFilter,
			HTML::Pipeline::SanitizationFilter,
			HTML::Pipeline::EmojiFilter
		], context

		result = pipeline.call(content)
		result[:output].to_s.html_safe
	end
end
