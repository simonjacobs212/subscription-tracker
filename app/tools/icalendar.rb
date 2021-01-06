module CalendarHandler

    def create_event
        cal = Icalendar::Calendar.new
        cal.event do |e|
            e.dtstart     = Icalendar::Values::Date.new('20210106')
            e.dtend       = Icalendar::Values::Date.new('20210107')
            e.summary     = "Meeting with the man."
            e.description = "Have a long lunch meeting and decide nothing..."
            e.ip_class    = "PRIVATE"
        end
        # binding.pry
        cal.publish
    end
    
    cal = Icalendar::Calendar.new

    # # Parse through some events and create an ical
    # events = [{dt: '2019-01-07', desc: 'Event 1'},{dt: '2019-01-08', desc: 'Event 2'}]
    # events.each {|ev|
    #   dt = Date.parse(ev[:dt])
    #   event = Icalendar::Event.new #our new event
    #   event.dtstart = Icalendar::Values::Date.new(dt)
    #   event.dtend   = Icalendar::Values::Date.new(dt + 1)
    #   event.summary = ev[:desc]
    #   event.transp = 'TRANSPARENT'
    #   cal.add_event(event)
    # }
    
    # cal_string = cal.to_ical
    # puts cal_string



end