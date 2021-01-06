module CalendarHandler

    def create_event
        cal = Icalendar::Calendar.new
        cal.event do |e|
            e.dtstart     = Icalendar::Values::Date.new('20050428')
            e.dtend       = Icalendar::Values::Date.new('20050429')
            e.summary     = "Meeting with the man."
            e.description = "Have a long lunch meeting and decide nothing..."
            e.ip_class    = "PRIVATE"
        end
        binding.pry
        cal.publish
    end
    

end