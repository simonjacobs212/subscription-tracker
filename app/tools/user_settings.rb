module UserSettings 
  include CliControls
  include LoginControl

  ######################## User Settings ############################
  def user_settings
    system 'clear'
    print_user_info
    user_settings_action_selection
  end

  def print_user_info
    @user.print_app_login_info
  end

  def user_settings_action_selection
    choices = ["Change SubscriptionTracker Username", "Change SubscriptionTracker Password", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do?", choices)
    case selection
    when "Change SubscriptionTracker Username"
      change_app_username_handler
    when "Change SubscriptionTracker Password"
      change_app_password_handler
    when "Back"
      system 'clear'
      main_menu
    when "Logout"
      system 'clear'
      run
    end
  end

  def change_app_username_handler
    @new_app_username = @@prompt.ask("Please enter your new SubscriptionTracker username: ", required: true)
    validate_new_username
    @user.update(app_username: @new_app_username)
    puts "✅ Your SubscriptionTracker username has been updated to #{@user.app_username}."
    @@prompt.keypress("Press space or enter to return to User Settings Menu", keys: [:space, :return])
    user_settings
  end

  def validate_new_username
    if !app_username_available?(@new_app_username)
      name_taken
      change_app_username_handler
    end
  end

  def change_app_password_handler
    @new_app_password = @@prompt.mask("Please enter your new SubscriptionTracker password: ", required: true, mask: @@heart)
    @repeat_password = @@prompt.mask("Re-enter your SubscriptionTracker to confirm: ", required: true, mask: @@heart)
    validate_new_password
    @user.update(app_password: @new_app_password)
    puts "✅ Your SubscriptionTracker password has been updated to #{@user.app_password}."
    @@prompt.keypress("Press space or enter to return to User Settings Menu", keys: [:space, :return])
    user_settings
  end

  def validate_new_password
    if !passwords_match?(@new_app_password)
      password_mismatch
      change_app_password_handler
    end
  end

end
