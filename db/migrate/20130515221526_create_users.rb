class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name, :password_hash, :email

      t.timestamps 
    end

    add_column :posts, :user_id, :integer
  end
end
