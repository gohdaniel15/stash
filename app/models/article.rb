class Article < ApplicationRecord
	has_many :upvotes
	belongs_to :user
	validates :url, presence: {message: "Please enter the article URL."}, url: {message: "Please enter a valid URL."}
	# scope :order_by_votes, ->{ joins(:upvotes).select('articles.title, 
	# 	articles.description,
	# 	articles.user_id,
	# 	articles.url,
	# 	articles.id,
	# 	sum(upvotes.vote) as vote_count').group('articles.id').order('vote_count desc') }

	def positive_votes
		upvotes.where(vote: true)
	end

	def positive_votes_count
		positive_votes.count
	end

	def self.sort_positive_votes
		joins(:upvotes).where('upvotes.vote = true').group('articles.id').order('count(upvotes.vote) asc, created_at desc')
	end

	def self.sort_negative_votes
		joins(:upvotes).where('upvotes.vote = false').group('articles.id').order('count(upvotes.vote) asc, created_at desc')
	end
end

