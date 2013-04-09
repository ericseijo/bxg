class CreateDistributionLists < ActiveRecord::Migration
  def change
    create_table :distribution_lists do |t|
      t.references :release, :null => false
      t.string :name, :null => false
      t.string :where
      t.string :where_area
      t.string :who
      t.string :who_sub
      t.string :what
      t.string :what_sub

      t.timestamps
    end

    add_index :distribution_lists, :release_id
  end
end
