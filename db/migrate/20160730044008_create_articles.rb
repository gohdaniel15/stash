class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.text :description
      t.boolean :general
      t.integer :week

      t.timestamps
    end
  end
end
