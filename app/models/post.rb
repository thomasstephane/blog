class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts_tags
  has_many :tags, through: :posts_tags

  validates :title, :content, presence: true
end
