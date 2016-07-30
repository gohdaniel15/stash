class Article < ApplicationRecord
	has_many :upvotes
	validates :url, presence: true
end
