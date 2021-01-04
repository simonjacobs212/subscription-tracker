class Reminder < ActiveRecord::Base
    belongs_to :reminded_subscription, class_name: "Subscription", foreign_key: "subscription_id"
    belongs_to :reminded_user, class_name: "User", foreign_key: "user_id"

    after_create :set_default_notice

    def set_default_notice
        self.update(days_notice: 7)
    end

    def reminder_date
        self.reminded_subscription.renewal_date.to_datetime - self.days_notice.days
    end    
end
    