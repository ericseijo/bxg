class CreateMediaLists < ActiveRecord::Migration
  def change
    create_table :media_lists do |t|
      t.string :company
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :fax
      t.decimal :circulation, :precision => 8, :scale => 2
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end
