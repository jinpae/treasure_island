module UsersHelper
	include ActsAsTaggableOn::TagsHelper

	def profile_image_for(user, *css_classes)
		url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?d=mm"

		image_tag url, alt: "User profile image", class: css_classes
	end

	def submitted_treasures_for(user)
		if user.has_treasures?
			render @owned_treasures
		else
			content_tag :p, "There are no treasures submitted by #{user.first_name} yet."
		end
	end
end
