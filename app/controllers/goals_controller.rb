class GoalsController < ApplicationController
  before_action :new_goal, only: [:new, :create]
  before_action :set_goal, only: [:update]

  def new
  end

  def create
    @goal.user_id = current_user.id
    @goal.content = params[:goal][:content]
    @goal.size = params[:goal][:size]
    @goal.save
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def index
    @goals = current_user.goals
    render partial: "index", locals: {:@goals => @goals}
  end

  def update
    @goal.toggle(:completion)
    @goal.save

    @goals_count = ((current_user.goals.where(completion: true).count.to_f)/(((current_user.created_at.to_date)..(Date.today)).to_a.count)).round(1)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def new_goal
    @goal = Goal.new
  end

  def set_goal
    @goal = Goal.find(params[:goal][:id])
  end

end
