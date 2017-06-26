class CreateStoryComments < ActiveRecord::Migration[5.0]
  def change
    create_table :story_comments do |t|
      t.integer :user_id
      t.integer :story_id
      t.string :comment

      t.timestamps
    end
  end
end
