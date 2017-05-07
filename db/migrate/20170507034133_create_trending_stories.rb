class CreateTrendingStories < ActiveRecord::Migration[5.0]
  def change
    create_table :trending_stories do |t|
      t.integer :story_id, index: true
      t.integer :batch

      t.timestamps
    end
  end
end
