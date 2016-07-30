class Article < ApplicationRecord
	has_many :upvotes
	validates :url, presence: {message: "Please enter the article URL."}, url: {message: "Please enter a valid URL."}
end
