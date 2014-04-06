class Post < ActiveRecord::Base
  include Comparable
  extend FriendlyId
  friendly_id :title, use: :slugged

	belongs_to :user

  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :user_id
  validates :link_url, presence: { if: :link }
  validate :link_url_format_valid?, if: :link

  # will_paginate number of posts per page
  self.per_page = 5

  def should_generate_new_friendly_id?
    title_changed?
  end

  public

  def draft?
    if !published
      true
    else
      false
    end
  end

  private

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
