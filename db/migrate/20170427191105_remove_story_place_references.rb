class RemoveStoryPlaceReferences < ActiveRecord::Migration[5.0]
  def change
    remove_reference(:stories, :place, index: true, foreign_key: true)
  end
end
