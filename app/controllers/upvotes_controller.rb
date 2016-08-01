class UpvotesController < ApplicationController

  def create
  	@article = Article.find(params[:article_id])
  	@vote = Upvote.find_or_initialize_by(user_id: current_user.id, article_id: params[:article_id])
		if @vote.new_record? 
			@vote.vote = true
		else
			@vote.toggle(:vote)
		end
	 	@vote.save
	 	@count = 0
    current_user.articles.each { |a| @count += a.upvotes.where(vote: true).count }
    
    @positive = @article.positive_votes.count.to_s

	 	respond_to do |format|
	 		format.js 
      format.html { redirect_to root_path }
      
    end
	end
end
