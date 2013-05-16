class CreatePostsTags < ActiveRecord::Migration
  def change
    create_table :posts_tag do |t|
      t.references :post, :tag

      t.timestamps
    end
  end
end