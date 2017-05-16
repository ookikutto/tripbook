class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followable_id
      t.string :followable_type

      t.timestamps
    end
  end
end
