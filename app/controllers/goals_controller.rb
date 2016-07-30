class GoalsController < ApplicationController
  before_action :new_goal, only: [:new, :create]
  before_action :set_goal, only: [:update]

  def new
  end

  def create
    @goal.user_id = current_user.id
    @goal.content = params[:goal][:content]
    @goal.size = params[:goal][:size]
    @goal.completion = false
    @goal.save
    redirect_to root_path
  end

  def index
  end

  def update
    @goal.completion = true
    @goal.save
    redirect_to root_path
  end

  private

  def new_goal
    @goal = Goal.new
  end

  def set_goal
    @goal = Goal.find_by(params[:goal][:id])
  end

end
