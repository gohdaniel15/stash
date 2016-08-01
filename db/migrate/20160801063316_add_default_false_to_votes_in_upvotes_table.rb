class AddDefaultFalseToVotesInUpvotesTable < ActiveRecord::Migration[5.0]
  def change
   	change_column :upvotes, :vote, :boolean, default: false 	
  end
end
