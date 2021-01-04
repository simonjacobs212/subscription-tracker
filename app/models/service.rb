class Service < ActiveRecord::Base
  has_many :service_categories
  has_many :categories, through: :service_categories
  has_many :subscriptions
  has_many :reminders, through: :subscriptions
  has_many :users, through: :subscriptions
end
