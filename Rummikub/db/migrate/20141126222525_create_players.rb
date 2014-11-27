class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_id, null: false
      t.index :game_id
      t.timestamps
    end
  end
end
