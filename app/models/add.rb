class Add < ApplicationRecord
  belongs_to :users, optional: true
  belongs_to :playlists, optional: true

  validates :url, presence: true
end
