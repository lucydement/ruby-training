class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :colour, null: false
      t.integer :number, null: false
      t.timestamps
    end
  end
end
