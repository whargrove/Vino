class Post < ActiveRecord::Base
	belongs_to :user

  validates_presence_of :title
  validates_presence_of :user_id
  validates :link_url, presence: { if: :link }
  validate :link_url_format_valid?

  public

  def link_url_format_valid?
    uri = URI.parse(link_url)
    if !uri.kind_of?(URI::HTTP)
      errors.add(:link_url, "must be a valid format")
    end
  rescue URI::InvalidURIError
    errors.add(:link_url, "must be a valid format")
    false
  end
end
