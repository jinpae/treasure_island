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
			content_tag :h1, class: "page-title" do
				"Displaying results for #{content_tag :span, (tag || search_keyword.values[0])}".html_safe
			end
		end
	end
end
