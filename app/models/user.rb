class User < ActiveRecord::Base
	has_many :posts

	has_secure_password

	validates_uniqueness_of :user_name
end
