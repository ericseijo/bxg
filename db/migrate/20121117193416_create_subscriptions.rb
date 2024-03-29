class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, :null => false
      t.integer :plan_id, :null => false
      t.string :status, :null => false

      t.timestamps
    end

    add_index :subscriptions, :user_id
  end
end