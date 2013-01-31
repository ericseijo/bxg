class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.string :ticker_symbol
      t.string :website

      t.timestamps
    end
    add_index :clients, :user_id
  end
end
