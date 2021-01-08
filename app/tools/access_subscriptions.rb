module AccessSubscriptions
  include NewSubscriptionControl
  include UpdateSubscriptionHandler
  include CalendarHandler

  def access_subscriptions
    custom_clear
    @subscription = pick_subscription
    case @subscription
    when "Add New Subscription"
      add_new_subscription
    when "Back"
      custom_clear
      main_menu
    when "Logout"
      custom_clear
      run
    else
      subscription_action
    end
  end

  def pick_subscription  #picture?
    choices = @user.create_subscription_menu_choices
    choices["Add New Subscription"] = "Add New Subscription"
    choices["Back"] = "Back"
    choices["Logout"] = "Logout"
    question = subscription_menu_prompts
    @@prompt.select(question, choices)
  end

  def user_has_subscriptions?
    !@user.subscriptions.empty?
  end

  def subscription_menu_prompts
    if user_has_subscriptions?
      "Which subscription would like to access?\n--------------------------------------\n"
    else
      "Add a new subscription to get started:\n--------------------------------------\n"
    end
  end

  def subscription_action
    custom_clear
    puts @subscription.display_subscription_info
    subscription_options = ["Access Reminder", "Update/Delete Susbcription", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do?", subscription_options)
    case selection
    when "Access Reminder"
      @subscription.reminder_exists? ? reminder_menu : no_current_reminder
      sleep (1.5)
      subscription_action
    when "Update/Delete Susbcription"
      custom_clear
      update_subscription_handler
    when "Back"
      custom_clear
      main_menu
    when "Logout"
      custom_clear
      run
    end
  end

  def reminder_menu
    custom_clear
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
      custom_clear
      main_menu
    when "Logout"
      custom_clear
      run
    end
  end

  def no_current_reminder
    puts "⚠️ No reminder is currently set for this subscription.".yellow
    play_warning_sound
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
    puts "Your reminder has been set for "+"#{@subscription.active_reminder.reminder_date.strftime("%b %d %Y")}.".light_blue
    puts "This will provide " + "#{days_notice}".light_blue + " days notice before your subscription ends."
  end

  def disable_reminder
    puts "⚠️ You will no longer be notified of the renewal date for this subscription.".yellow
    play_warning_sound
    yes_no("Do you wish to continue?".yellow) ? @subscription.disable_reminder_for_subscription : reminder_menu
    puts "✅ Your reminder has been set for #{@subscription.active_reminder.reminder_date.strftime("%b %d %Y")} which will provide #{days_notice} days notice.".green
    play_single_coin
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
    event = @reminder.create_event_obj 
    @user.create_user_directory
    create_calendar_obj(event)
    @filename = @reminder.create_reminder_filename
    delete_old_file if file_exists?
    create_ics_file
    open_ics_file
  end

end