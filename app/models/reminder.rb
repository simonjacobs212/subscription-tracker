class Reminder < ActiveRecord::Base
    belongs_to :subscription

    after_create :set_default_notice

    def set_default_notice
        self.update(days_notice: 7) if self.days_notice.nil?
    end

    def reminder_date
        self.subscription.renewal_date.to_datetime - self.days_notice.days
    end

    def create_event_hash
        info = {
            dt: "#{self.reminder_date}", 
            summary: "#{self.subscription.service.name} is expiring!" , 
            desc: "Your #{self.subscription.service.name} subscription is set to expire on #{self.subscription.renewal_date}. Be sure to login to #{self.subscription.service.url} to cancel your subscription if you would not like to renew."
            }
            event = Icalendar::Event.new
            event.dtstart = Icalendar::Values::Date.new(Date.parse(info[:dt]))
            event.dtend   = Icalendar::Values::Date.new(Date.parse(info[:dt] + "#{self.days_notice.days}"))
            event.summary = info[:summary]
            event.description = info[:desc]
            event.ip_class = "PRIVATE"
            event.transp = 'TRANSPARENT'
            cal.add_event(event)
            binding.pry
        # events.each {|ev|
        #     dt = Date.parse(ev[:dt])
        #     event = Icalendar::Event.new #our new event
        #     event.dtstart = Icalendar::Values::Date.new(dt)
        #     event.dtend   = Icalendar::Values::Date.new(dt + 1)
        #     event.summary = ev[:desc]
        #     event.transp = 'TRANSPARENT'
        #     cal.add_event(event)
        #     }
    end

end
    