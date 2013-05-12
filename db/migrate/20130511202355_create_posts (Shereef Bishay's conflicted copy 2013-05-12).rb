class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :content
      t.boolean :published

      t.timestamp
    end
  end
end
