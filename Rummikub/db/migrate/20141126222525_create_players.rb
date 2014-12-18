class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :game_id, null: false
      t.integer :user_id, null: false
      t.integer :number, null: false
      t.boolean :passed
      t.index :game_id
      t.index :user_id
      t.timestamps
    end
  end
end
