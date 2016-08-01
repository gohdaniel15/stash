class Article < ApplicationRecord
	has_many :upvotes
	belongs_to :user
	validates :url, presence: {message: "Please enter the article URL."}, url: {message: "Please enter a valid URL."}
		
	def positive_votes
		upvotes.where(vote: true)
	end
end

