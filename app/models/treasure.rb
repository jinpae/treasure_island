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

	self.per_page = 2

	scope :by_letter, ->(letter) { where("treasures.name like ?", "#{letter}%") }
	scope :letter_indices, -> { find_by_sql("SELECT DISTINCT SUBSTR(name, 1, 1) AS name FROM treasures ORDER BY name") }
	scope :recent, -> (n = 5) { order(created_at: :desc).limit(n) }
	scope :popular, -> (n = 5) { order(cached_votes_up: :desc).limit(n) }

	def self.letter_indices
		@treasures_with_first_letter ||= find_by_sql("SELECT DISTINCT SUBSTR(name, 1, 1) AS name FROM treasures ORDER BY name")

		# Return an array of unique first letters.
		@treasures_with_first_letter.map(&:name)
	end

	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end

	def self.treasure_count
		@count ||= Treasure.count
	end
end
