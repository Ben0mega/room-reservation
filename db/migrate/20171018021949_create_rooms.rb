class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :number
      t.integer :capacity
      t.references :building, index: true, foreign_key: true
      t.text :facilities
      t.text :misc
    end
  end
end
