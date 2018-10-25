class Course < ApplicationRecord
  has_many :course_users
  has_many :topics
  belongs_to :category
end
