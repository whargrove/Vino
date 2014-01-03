class Post < ActiveRecord::Base
	belongs_to :user

  validates_presence_of :title
  validates_presence_of :user_id
  validates :link_url, presence: { if: :link }
end
