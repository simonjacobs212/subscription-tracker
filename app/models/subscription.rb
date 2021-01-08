
class Subscription < ActiveRecord::Base
  belongs_to :service
  belongs_to :user
  has_many :reminders
  include CalendarHandler
  after_create :set_default_start_date
  after_create :initialize_renewal
  


  def set_default_start_date
      self.update(start_date: self.created_at) if self.start_date.nil?
  end

  def set_start_date(date)
    self.update(start_date: date)
  end

  def initialize_renewal
    new_date = (self.start_date + self.duration.days)
    self.update(renewal_date: new_date)
  end

  def update_renewal_date
    new_date = (DateTime.now + self.duration.days)
    self.update(renewal_date: new_date)
  end

  def custom_renewal_date
    new_date = (self.start_date + self.duration.days)
    self.update(renewal_date: new_date)
  end


  def days_remaining
    days_left = (self.reload.renewal_date.to_datetime - DateTime.now)
    return days_left.to_i if days_left.to_i > 0
    "⚠️ Expired.".yellow
  end

  ############################### Renew Sub ##############################
  def renew_subscription
    new_renewal_date = self.renewal_date + self.duration
    new_start_date = self.renewal_date
    self.update(start_date: new_start_date, renewal_date: new_renewal_date)
  end

  def set_new_auto_reminder
    self.set_reminder(self.days_notice)
    puts "✅ Your reminder has been set for #{self.active_reminder.reminder_date.strftime("%b %d %Y")}".green
    puts "This will provide " + "#{self.days_notice}".light_blue + " days notice before your subscription ends."
  end

  def set_new_auto_cal
      reminder = self.active_reminder
      event = reminder.create_event_obj 
      self.user.create_user_directory
      cal = Icalendar::Calendar.new
      cal.add_event(event)
      filename = reminder.create_reminder_filename
      delete_old_file if file_exists?
      create_ics_file
      open_ics_file
  end



  def change_subscription(hash)
    self.update(hash)
  end

  def delete_subscription
    self.destroy
    puts "💥 Your subscription has been deleted.".yellow
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
