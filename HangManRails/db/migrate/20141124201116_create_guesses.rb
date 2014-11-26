class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :game_id, null: false
      t.string :letter, null: false
      t.index :game_id
      t.timestamps
    end
  end
end
