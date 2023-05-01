class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original_url
      t.string :short_url
      t.integer :visit_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
