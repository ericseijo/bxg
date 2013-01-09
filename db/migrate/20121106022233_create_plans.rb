class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :level
      t.decimal :price, :precision => 8, :scale => 2, :null => false
      t.integer :number_of_releases_per_month, :null => false
      t.string :storage_space, :null => false
      t.integer :number_of_user_accounts, :null => false
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
