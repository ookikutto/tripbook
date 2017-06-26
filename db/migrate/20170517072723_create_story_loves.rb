class CreateStoryLoves < ActiveRecord::Migration[5.0]
  def change
    create_table :story_loves do |t|
      t.references :user, foreign_key: true, index: true
      t.references :story, foreign_key: true, index: true

      t.timestamps
    end
    add_index :story_loves, [:user_id, :story_id], unique: true

  end
end
