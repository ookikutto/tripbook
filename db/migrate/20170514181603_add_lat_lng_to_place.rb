class AddLatLngToPlace < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :lat, :string
    add_column :places, :lng, :string
    add_column :places, :place_id, :string
  end
end
