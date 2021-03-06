module ApplicationHelper
	def pluralize_without_count(count, singular, plural=nil)
		(count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize)
	end

	def nav_search_field
		unless current_page? root_path
			render "shared/search_form", q: @q
		end
	end

	def nav_link_to(link_text=nil, link_path=nil, css_classes=nil, &block)
		link_path, css_classes = link_text, link_path if block_given?

		css_classes ||= []
		css_classes << 'active' if current_page? link_path

		if block_given?
			link_to link_path, class: css_classes do
				capture &block
			end
		else
			link_to link_text, link_path, class: css_classes
		end
	end

	def page_title(title)
		content_for :title, title.dup.concat(' | Treasure Island')
	end

	def footer_link_to(link_text=nil, link_path=nil, options=nil, &block)
		link_path, options = link_text, link_path if block_given?
		options ||= {}
		options[:target] = '_blank'

		if block_given?
			link_to link_path, options do
				capture(&block)
			end
		else
			link_to link_text, link_path, options
		end
	end
end
