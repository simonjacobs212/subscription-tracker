class Reminder < ActiveRecord::Base
    belongs_to :reminded_subscription, class_name: "Subscription", foreign_key: "subscription_id"
    belongs_to :reminded_user, class_name: "User", foreign_key: "user_id"
end
    