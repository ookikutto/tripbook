class AddPlaceToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :place_id, :integer
  end
end
