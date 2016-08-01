class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

	def welcome
    if current_user.nil?
      redirect_to sign_in_path
    else
      set_user

      @articles = Article.all

      @goals = current_user.goals.all
      @goal = Goal.new

      # Goals Count
      @goals_count = (current_user.goals.where(completion: true).count.to_f)/([current_user.created_at.beginning_of_day..Date.today.end_of_day].count)

      # Articles Count
      @user_articles = current_user.articles.count

      # Upvote Count
      @count = 0
      current_user.articles.each { |a| @count += a.upvotes.where(vote: true).count }
    end
	end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = current_user
  end

end
