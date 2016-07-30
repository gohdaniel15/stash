class UpvotesController < ApplicationController
  def create
  	@article = Article.find(params[:format])
  	@vote = Upvote.find_or_initialize_by(user_id: current_user.id, article_id: params[:format])
		if @vote.new_record? 
			@vote.vote = true
		else
			@vote.toggle(:vote)
		end
		@vote.save
		redirect_to root_url
	end
end
