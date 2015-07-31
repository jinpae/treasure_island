module TreasuresHelper
	def tag_link_to(treasure)
		treasure.tag_list.map do |tag|
			# tag is a string, representing current tag in the array
			link_to tag, tag_path(tag), class: "tag"
		end.join(", ").html_safe
	end
end
