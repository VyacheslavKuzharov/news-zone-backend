class News < ApplicationRecord
  mount_uploader :image, ImageUploader
  paginates_per 15

  has_many :photos, dependent: :destroy
  # has_many :comments
  belongs_to :site
  belongs_to :city
  belongs_to :region

  scope :last_date, -> { order('date desc').first.date rescue Date.new(2009,11,26).to_time }
  scope :top_news, -> { where(in_top: true) }
end
