class Treasure < ActiveRecord::Base
	acts_as_taggable
	acts_as_votable

  belongs_to :user

	validates :name, :url, :description, presence: true
	validates :url, url: true, if: "url.present?"
	validates :url, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }, if: "url.present?"

	self.per_page = 20
end
