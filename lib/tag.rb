class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates :tag, presence: true, uniqueness: true
end
