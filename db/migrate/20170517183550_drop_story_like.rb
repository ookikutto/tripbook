class DropStoryLike < ActiveRecord::Migration[5.0]
  def change
    drop_table :story_likes
  end
end
