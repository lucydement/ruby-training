class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :colour, null: false
      t.integer :number, null: false
      t.integer :tile_set_order
      t.integer :game_id
      t.integer :player_id
      t.integer :tile_set_id
      t.index :tile_set_order
      t.index :game_id
      t.index :player_id
      t.index :tile_set_id
      t.timestamps
    end
  end
end
