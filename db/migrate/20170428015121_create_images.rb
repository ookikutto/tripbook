class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.integer :user_id
      t.string :title
      t.string :file

      t.timestamps
    end
  end
end
