class Treasure < ActiveRecord::Base
	extend FriendlyId

	acts_as_taggable
	acts_as_votable

  belongs_to :user

	validates :name, :url, :description, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	validates :url, url: true, if: "url.present?"
	validates :url, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }, if: "url.present?"

	friendly_id :name, use: [:slugged, :history]

	self.per_page = 20

	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end
end
