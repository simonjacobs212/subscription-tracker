require_all 'app/tools'

module AccessSubscriptions
  include NewSubscriptionControl
  include UpdateSubscriptionHandler
  include CalendarHandler

  def access_subscriptions
    system 'clear'
    @subscription = pick_subscription
    case @subscription
    when "Add New Subscription"
      add_new_subscription
    when "Back"
      system 'clear'
      main_menu
    when "Logout"
      system 'clear'
      run
    else
      subscription_action
    end
  end

  def pick_subscription
    choices = @user.create_subscription_menu_choices
    choices["Add New Subscription"] = "Add New Subscription"
    choices["Back"] = "Back"
    choices["Logout"] = "Logout"
    @@prompt.select("Which subscription would like to access?\n--------------------------------------\n", choices)
  end

  def subscription_action
    system 'clear'
    puts @subscription.display_subscription_info
    subscription_options = ["Access Reminder", "Update/Delete Susbcription", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do?", subscription_options)
    case selection
    when "Access Reminder"
      @subscription.reminder_exists? ? reminder_menu : no_current_reminder
      sleep (1.5)
      subscription_action
    when "Update/Delete Susbcription"
      system 'clear'
      update_subscription_handler
    when "Back"
      system 'clear'
      main_menu
    when "Logout"
      system 'clear'
      run
    end
  end

  def reminder_menu
    system 'clear'
    @subscription.display_active_reminder_for_subscription
    choices = ["Change Days Notice", "Disable Reminder", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do?", choices)
    case selection
    when "Change Days Notice"
      create_reminder_and_file
      access_subscriptions
    when "Disable Reminder"
      disable_reminder
    when "Back"
      system 'clear'
      main_menu
    when "Logout"
      system 'clear'
      run
    end
  end

  def no_current_reminder
    puts "⚠️ No reminder is currently set for this subscription."
    yes_no("Would you like to set one now?") ? create_reminder_and_file : subscription_action
  end

  def ask_days_notice
    days_notice = @@prompt.ask("Enter the number of days (1-99) in advance of the renewal date that you would like to be notified: ") do |response|
      response.validate(/\b[0-9]{1,2}\b/)
      response.messages[:valid?] = 'Invalid entry number. Please enter the number of DAYS notice (1-99) you want for this reminder.'
    end
    days_notice.to_i
  end

  def set_new_reminder
    days_notice = ask_days_notice
    @subscription.set_reminder(days_notice)
    puts "Your reminder has been set for #{@subscription.active_reminder.reminder_date.strftime("%b %d %Y")} which will provide #{days_notice} days notice."
    @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
  end

  def disable_reminder
    puts "⚠️ You will no longer be notified of the renewal date for this subscription."
    yes_no("Do you wish to continue?") ? @subscription.disable_reminder_for_subscription : reminder_menu
  end

  def create_reminder_and_file
    set_new_reminder
    create_calendar_reminder if make_calendar_event?
  end

  def make_calendar_event?
    yes_no("Would you like to add an event to your calendar for this reminder?")
  end

  def create_calendar_reminder
    @reminder = @subscription.active_reminder
    event = @reminder.create_event_obj #NOT FINAL
    @user.create_user_directory
    create_calendar_obj(event)
    filename = @reminder.create_reminder_filename
    create_ics_file(filename)
    open_ics_file(filename)
  end

end