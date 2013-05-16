class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many_and_belongs_to_many :posts

  validates :name, presence: true, uniqueness: true
end
