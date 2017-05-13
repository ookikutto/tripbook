class CreateImpressions < ActiveRecord::Migration[5.0]
  def change
    create_table :impressions do |t|
      t.integer :impressionable_id, index: true
      t.string :impressionable_type
      t.integer :user_id, index: true
      t.string :ip_address, index: true
    end
  end
end
