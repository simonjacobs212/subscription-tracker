# module CalendarHandler

    def create_calendar_obj(event)
        @cal = Icalendar::Calendar.new
        @cal.add_event(event)
    end

    def create_ics_file(filename)
        cal_string = @cal.to_ical
        File.open("reminder_files/#{@user.app_username}/#{filename} ","w") {|f| f.write "#{cal_string}"}
    end

    def open_ics_file(filename)
        system 'open','./reminder_files/#{@user.app_username}/filename'
    end

    def create_calendar_reminders
        event = REMINDER.create_event_obj #NOT FINAL
        @user.create_user_directory
        create_calendar_obj(event)
        filename = REMINDER.create_reminder_filename
        create_ics_file(filename)
        open_ics_file(filename)
    end

# end