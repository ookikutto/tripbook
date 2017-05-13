class CreateTrendingPlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :trending_places do |t|
      t.integer :place_id, index: true
      t.integer :batch

      t.timestamps
    end
  end
end
