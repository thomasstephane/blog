class Post < ActiveRecord::Base
  # Remember to create a migration!
  has_and_belongs_to_many :tags
  belongs_to :user

  validates :title, :content, presence: true
end
