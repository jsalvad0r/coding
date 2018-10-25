class User < ApplicationRecord
  has_many :interest_users
  has_many :course_users
end
