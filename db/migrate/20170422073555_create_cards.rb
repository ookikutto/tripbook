class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :story, foreign_key: true
      t.string :photo
      t.string :caption
      t.integer :prev_id, index: true
      t.integer :next_id, index: true

      t.timestamps
    end
  end
end
