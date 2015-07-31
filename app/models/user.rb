class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :first_name, presence: true
	validates :last_name, presence: true

	has_many :treasures
	has_many :tags, through: :treasures

	# Returns tags with single user's taggings counts via association.
	def tag_counts
		user_tags = tags.pluck(:name)
		user_tag_list = Hash.new(0)

		user_tags.each do |t|
			user_tag_list[t] += 1
		end

		tmp_tags = treasures.tag_counts_on(:tags)
		tmp_tags.map do |t|
			t.taggings_count = user_tag_list[t.name]
		end

		tmp_tags
	end
end
