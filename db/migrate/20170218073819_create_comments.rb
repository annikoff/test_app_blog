class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false, default: ''
      t.integer :author_id, null: false
      t.integer :post_id, null: false
      t.datetime :published_at, null: false
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end
