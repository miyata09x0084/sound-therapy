class Emotion < ApplicationRecord
    belongs_to :user, optional: true

    scope :with_weekly_data, -> { where("updated_at": 1.week.ago.beginning_of_day..Time.zone.now.end_of_day) }
    scope :with_monthly_data, -> { where("updated_at": 1.month.ago.beginning_of_day..Time.zone.now.end_of_day) }
    scope :search_with_feeling, ->(feeling) { pluck(feeling) }
end


