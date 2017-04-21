class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
      t.references :place, foreign_key: true, index: true
      t.string :title
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
