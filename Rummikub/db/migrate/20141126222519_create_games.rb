class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :current_player
      t.integer :number_players

      t.timestamps
    end
  end
end
