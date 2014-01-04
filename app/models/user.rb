class User < ActiveRecord::Base
	has_many :posts

	has_secure_password

	validates_uniqueness_of :user_name
  validates_presence_of :user_name
  validates_presence_of :first_name
  validates_presence_of :last_name
end
