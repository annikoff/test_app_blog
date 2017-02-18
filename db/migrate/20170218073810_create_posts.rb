class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false, default: ''
      t.integer :author_id, null: false
      t.datetime :published_at, null: false
      t.timestamps
    end

    add_index :posts, :author_id
  end
end
