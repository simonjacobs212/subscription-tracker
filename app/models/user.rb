class User < ActiveRecord::Base
    has_many :reminders
    has_many :subscriptions
end
  