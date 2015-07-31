class Treasure < ActiveRecord::Base
	acts_as_taggable

  belongs_to :user

	validates :name, :url, :description, presence: true
	validates :url, url: true
	validates :url, format: { with: /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i }
end
