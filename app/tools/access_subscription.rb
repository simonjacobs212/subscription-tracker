require_all 'app/tools'

module AccessSubscriptions
  include CliControls
  include LoginControl

  def access_subscriptions
    system 'clear'
    @subscription = pick_subscription
    subscription_action
  end

  def pick_subscription
    choices = @user.create_subscription_menu_choices
    subscription = @@prompt.select("Which subscription would like to access?", choices)
  end

  def subscription_action
    system 'clear'
    @subscription.display_subscription_info
    subscription_options = ["View Reminder", "Disable Reminder", "Create New Reminder", "Update Susbcription"]
    selection = @@prompt.select("What would you like to do?", subscription_options)
    case selection
    when "View Reminder"
      @subscription.display_active_reminder_for_subscription
      @@prompt.keypress("Press space or enter to return to User Settings Menu", keys: [:space, :return])
      subscription_action
    when "Disable Reminder"
      # change_app_password_handler
    when "Back"
      system 'clear'
      main_menu
    when "Logout"
      system 'clear'
      run
    end
  end

end