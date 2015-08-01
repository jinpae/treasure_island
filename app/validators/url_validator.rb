class UrlValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless valid_url?(record, value)
			record.errors[attribute] << (options[:message] || "has already been submitted")
		end
	end

	private
		def valid_url?(record, url)
			# Add trailing slash if it doesn't have one.
			url << '/' unless url.ends_with? '/'
	
			https_url = url.gsub("http:", "https:")
			http_url = url.gsub("https:", "http:")
	
			has_duplicate_url = find_by_url(https_url) || find_by_url(http_url)
	
			has_duplicate_url ? record == (find_by_url(https_url) || find_by_url(http_url)) : false
		end
	
		def find_by_url(url)
			Treasure.find_by(url: url)
		end
end
