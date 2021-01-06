module CalendarHandler

    def create_calendar_obj(event)
        @cal = Icalendar::Calendar.new
        @cal.add_event(event)
    end

    def create_ics_file(filename)
        cal_string = @cal.to_ical
        File.open("reminder_files/#{@user.app_username}/#{filename} ","w") {|f| f.write "#{cal_string}"}
        sleep(3.0)
    end

    def open_ics_file(filename)
        system 'open', "./reminder_files/'#{@user.app_username}'/'#{filename}'"
    end

end