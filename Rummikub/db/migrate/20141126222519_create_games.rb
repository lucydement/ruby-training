class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :active_player_number
      t.integer :total_player_count

      t.timestamps
    end
  end
end
