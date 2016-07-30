class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	has_many :upvotes
	has_many :goals, dependent: :destroy
	has_many :upvotes, through: :articles

	def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth[:info][:name]
      user.email = auth[:info][:email]
      user.avatar = auth[:info][:image]
    end
  end
end
