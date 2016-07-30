class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

	def welcome
    if current_user.nil?
      redirect_to sign_in_path
    else
      set_user

      @articles = Article.all

      @goals = Goal.all
      @goal = Goal.new
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
