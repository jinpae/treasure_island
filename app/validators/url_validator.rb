class UrlValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		value << '/' unless value.ends_with? '/'

		https_url = value.gsub("http:", "https:")
		http_url = value.gsub("https:", "http:")

		if Treasure.find_by(url: https_url) || Treasure.find_by(url: http_url)
			record.errors[attribute] << (options[:message] || "has already been submitted")
		end
	end
end
