class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :misc
      t.float :lng
      t.float :lat
    end
  end
end
