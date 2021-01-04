class Subscription < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  has_many :reminders
  has_many :reminded_users, through: :reminders
end
