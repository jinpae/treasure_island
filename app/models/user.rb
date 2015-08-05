class User < ActiveRecord::Base
	extend FriendlyId

	acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :first_name, :last_name, :username, presence: true
	validates :username,
						length: { minimum: 3 },
						format: /\A[A-Z0-9]+[-_]*[A-Z0-9]+\z/i,
						uniqueness: { case_sensitive: false }

	has_many :treasures
	has_many :tags, through: :treasures

	friendly_id :username
	
	def should_generate_new_friendly_id?
		slug.blank? || username_changed?
	end

	# Returns tags with single user's taggings counts via association.
	def tags_with_user_tag_counts
		user_tags = tags.pluck(:name)
		user_tag_list = Hash.new(0)

		user_tags.each do |t|
			user_tag_list[t] += 1
		end

		tags = treasures.tag_counts_on(:tags)
		tags.map do |t|
			t.taggings_count = user_tag_list[t.name]
		end

		tags
	end

	def toggle_heart(treasure)
		(self.hearted? treasure) ? self.unlike(treasure) : self.likes(treasure)

	end

	def gravatar_id
		Digest::MD5::hexdigest(email.downcase)
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def hearted_treasures
		find_liked_items
	end

	def has_treasures?
		treasures.count > 0
	end

	def has_hearted_treasures?
		hearted_treasures.size > 0
	end

	def hearted?(treasure)
		voted_for? treasure
	end
end
