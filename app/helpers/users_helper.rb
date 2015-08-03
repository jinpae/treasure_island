module UsersHelper
	def profile_image_for(user, *css_classes)
		url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?d=mm"

		image_tag url, alt: "User profile image", class: css_classes
	end
end
