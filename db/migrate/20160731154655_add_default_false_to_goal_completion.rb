class AddDefaultFalseToGoalCompletion < ActiveRecord::Migration[5.0]
  def change
  	change_column :goals, :completion, :boolean, default: false
  end
end
