module CalendarHandler
    include CliControls

    def create_calendar_obj(event)
        @cal = Icalendar::Calendar.new
        @cal.add_event(event)
    end
    
    def file_exists?
        File.exists?("reminder_files/#{@user.app_username}/#{@filename}")
    end

    def delete_old_file
        File.delete("reminder_files/#{@user.app_username}/#{@filename}")
        puts "A new calendar event is about to be created."
        puts "Please note that the existing calendar event for #{@reminder.subscription.service.name} in your Calendar App still exists."
        puts "You must manually delete the old event through the Calendar App."
        @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    end

    def create_ics_file
        cal_string = @cal.to_ical
        File.open("reminder_files/#{@user.app_username}/#{@filename}","w") {|f| f.write "#{cal_string}"}
    end

    def open_ics_file
        system 'open', "./reminder_files/#{@user.app_username}/#{@filename}"
    end

end