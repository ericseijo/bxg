class CreateReleasePickups < ActiveRecord::Migration
  def change
    create_table :release_pickups do |t|
      t.integer :release_id
      t.integer :media_list_id

      t.timestamps
    end
    add_index :release_pickups, :release_id
  end
end
