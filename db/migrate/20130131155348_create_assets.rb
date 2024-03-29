class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :assetable, :polymorphic => true
      t.string :name
      t.string :media_file_name
      t.string :media_content_type
      t.integer :media_file_size
      t.datetime :media_updated_at

      t.timestamps
    end
  end
end
