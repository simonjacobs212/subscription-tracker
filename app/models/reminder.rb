class Reminder < ActiveRecord::Base
    belongs_to :subscription

    after_create :set_default_notice

    def set_default_notice
        self.update(days_notice: 7)
    end

    def reminder_date
        self.subscription.renewal_date.to_datetime - self.days_notice.days
    end    
end
    