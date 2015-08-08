module ApplicationHelper
	def pluralize_without_count(count, singular, plural=nil)
		(count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize)
	end

	def nav_search_field
		unless current_page? root_path
			render "shared/search_form", q: @q
		end
	end
end
