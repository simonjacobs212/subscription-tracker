class Reminder < ActiveRecord::Base
    belongs_to :subscription

    after_create :set_default_notice

    def set_default_notice
        self.update(days_notice: 7) if self.days_notice.nil?
    end

    def reminder_date
        # binding.pry
        self.subscription.reload.renewal_date.to_datetime - self.days_notice.days
    end

    def create_event_obj
        info = {
            dt: "#{self.reload.reminder_date}", 
            summary: "\u{1F4B0} #{self.subscription.service.name} is expiring!" , 
            desc: "Your #{self.subscription.service.name} subscription for the email address #{self.subscription.email} is set to expire on #{self.subscription.renewal_date.strftime("%b %d %Y")}. Be sure to login to #{self.subscription.service.url} to cancel your subscription if you do not wish to renew."
            }
        event = Icalendar::Event.new
            event.dtstart = Icalendar::Values::Date.new(Date.parse(info[:dt]))
            event.dtend   = Icalendar::Values::Date.new(Date.parse(info[:dt]) + (self.days_notice + 1).days)
            event.summary = info[:summary]
            event.description = info[:desc]
            event.ip_class = "PRIVATE"
            event.transp = 'TRANSPARENT'
        return event
    end
    
    def create_reminder_filename
        "#{self.subscription.reload.service.name}.ics"
    end



end
    