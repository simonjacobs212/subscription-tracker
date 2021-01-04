class Reminder < ActiveRecord::Base
    belongs_to :subscription
    belongs_to :reminded_user, class_name: "User", foreign_key: "user_id"
end
    