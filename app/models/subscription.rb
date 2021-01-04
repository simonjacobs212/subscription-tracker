class Subscription < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  has_many :reminders
  has_many :reminded_users, through: :reminders

  after_create :initialize_renewal

  def initialize_renewal
    self.update(renewal_date: (self.created_at.to_datetime + self.duration.days))
  end


  def days_remaining
    return (self.renewal_date.to_datetime - DateTime.now).to_i if (self.renewal_date.to_datetime - DateTime.now).to_i > 0
    "⚠️ This subscription has expired"
  end

  def change_subscription(hash)
    self.update(hash)
  end

  def delete_subscription
    self.destroy
  end

  def reminder_exists?
    !Reminder.find_by(subscription_id: self.id).nil?
  end

  def active_reminder
    Reminder.find_by(subscription_id: self.id, active: true)
  end
end
