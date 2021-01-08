class Subscription < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  has_many :reminders

  after_create :initialize_renewal

  def initialize_renewal
    self.update(renewal_date: (self.created_at.to_datetime + self.duration.days))
  end

  def update_renewal_date
    self.update(renewal_date: (DateTime.now + self.duration.days))
  end


  def days_remaining
    return (self.renewal_date.to_datetime - DateTime.now).to_i if (self.renewal_date.to_datetime - DateTime.now).to_i > 0
    "⚠️ This subscription has expired.".yellow
    play_warning_sound
  end

  def change_subscription(hash)
    self.update(hash)
  end

  def delete_subscription
    self.destroy
    puts "💥 Your subscription has been deleted.".yellow
    play_explosion
    sleep (1.5)
  end

  def reminder_exists?
    !self.active_reminder.nil?
  end

  def active_reminder
    Reminder.find_by(subscription_id: self.id, active: true)
  end

  def set_reminder(days_notice)
    reminder = Reminder.find_or_create_by(subscription_id: self.id, active: true)
    reminder.update(days_notice: days_notice)
  end

  def disable_reminder_for_subscription
    reminder = self.active_reminder
    reminder.update(active: false)
  end

  def display_subscription_info
    "Service Name: #{self.service.name}\n Cost per #{self.duration} days: $#{sprintf('%.2f', self.cost_per_duration.to_s)}\n Days until expiration: #{self.days_remaining}\n--------------------------------------"
  end

  def display_active_reminder_for_subscription
    puts "Service Name: #{self.service.name}"
    puts "Expiration reminder will be sent on: #{self.active_reminder.reminder_date.strftime("%b %d %Y")}"
    puts "-----------------------------------------------------"
  end

  def normalize_cost
    self.cost_per_duration / self.duration
  end

end
