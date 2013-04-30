class CreateMediaContactMessages < ActiveRecord::Migration
  def change
    create_table :media_contact_messages do |t|
      t.string :originator
      t.integer :release_id
      t.integer :media_list_id
      t.text :message

      t.timestamps
    end
    add_index :media_contact_messages, :release_id
  end
end
