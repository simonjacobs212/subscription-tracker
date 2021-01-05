class SubscriptionTracker
  include CliControls
  include LoginControl
  include UserSettings
  include AccessSubscriptions

  # here will be your CLI!
  # it is not an AR class so you need to add attr

  def run
    welcome
    @user = login_or_signup
    say_hi_to_user
    display_active_reminders_for_user if !@user.upcoming_renewals.empty?
    main_menu    
  end

  private
  
  def welcome
    system 'clear'
    puts "Welcome to SubscriptionTracker!"
    sleep(0.3)
  end

  def say_hi_to_user
    system 'clear'
    puts "Welcome #{@user.first_name.capitalize}"
  end

  def display_active_reminders_for_user
    puts "\n"
    @user.display_upcoming_renewals
    @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    system 'clear'
  end

  def main_menu
    choices = ["My Subscriptions", "Access User Settings", "Logout"]
    selection = @@prompt.select("What would you like to do today?", choices)
    case selection
    when "My Subscriptions" 
      access_subscriptions
    when "Access User Settings"
      user_settings
    when "Logout"
      system 'clear'
      run
    end
  end

end

