class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.references :user
      t.integer :client_id
      t.string :name, :null => false
      t.string :status, :null => false
      t.string :headline
      t.string :sub_headline
      t.text :body
      t.string :link
      t.datetime :publish_date

      t.timestamps
    end
    add_index :releases, :user_id
  end
end
