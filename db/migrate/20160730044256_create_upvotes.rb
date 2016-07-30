class CreateUpvotes < ActiveRecord::Migration[5.0]
  def change
    create_table :upvotes do |t|
    	t.integer :article_id
    	t.integer :user_id
      t.boolean :vote

      t.timestamps
    end
  end
end
