class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :colour, null: false
      t.integer :number, null: false
      t.integer :game_id
      t.integer :player_id
      t.integer :x 
      t.integer :y
      t.index :game_id
      t.index :player_id
      t.timestamps
    end

    add_column :tiles, :on_board, :boolean, default: false
  end
end
