class Emotion < ApplicationRecord
    belongs_to :user, optional: true
end
