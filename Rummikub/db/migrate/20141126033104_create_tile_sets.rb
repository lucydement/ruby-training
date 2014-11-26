class CreateTileSets < ActiveRecord::Migration
  def change
    create_table :tile_sets do |t|

      t.timestamps
    end
  end
end
