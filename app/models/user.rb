class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :emotions
  has_many :playlists
  has_many :adds

  validates :name, presence: true
end
