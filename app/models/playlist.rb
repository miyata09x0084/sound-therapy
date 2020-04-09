class Playlist < ApplicationRecord
  belongs_to :user
  has_many :adds

  validates :name, presence: true, uniqueness: true
  mount_uploader :image, ImageUploader
end
