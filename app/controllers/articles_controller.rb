class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
  	@article = Article.new
  end

  def create
  	@article = Article.new(article_params)
  	@article.user_id = current_user.id
  	if @article.save
  		redirect_to root_url
  		respond_to do |format|
				format.html { redirect_to root_url }
 				format.js
 			end
 		else
 			flash[:danger] = @article.errors.values.flatten.first
 			respond_to do |format|
 				format.html { redirect_to root_url }
 				format.js
 			redirect_to root_url
 			end
 		end
  end

  def fetch
    

    respond_to do |format|
      format.js
    end
  end

  private

  def article_params
  	params.require(:article).permit(:title, :url, :description)
  end
end
