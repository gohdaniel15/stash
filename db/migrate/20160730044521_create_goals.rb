class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :content
      t.string :size

      t.timestamps
    end
  end
end
