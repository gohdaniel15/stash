module GoalsHelper
  def method_name
    start_of_day = self.beginning_of_day
    end_of_day = self.end_of_day
    completed_goals_a_day = Goal.where(created_at: start_of_day .. end_of_day, completion: true).count
    goals_a_day = Goal.where(created_at: start_of_day .. end_of_day).count
  end
end
