class SubscriptionTracker
  include CliControls
  include LoginControl
  include UserSettings
  # here will be your CLI!
  # it is not an AR class so you need to add attr

  def run
    welcome
    @user = login_or_signup
    say_hi_to_user
    display_active_reminders if !@user.upcoming_renewals.empty?
    initial_menu    
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

  def display_active_reminders
    puts "\n"
    @user.display_upcoming_renewals
    @@prompt.keypress("Press space or enter to return to User Settings Menu", keys: [:space, :return])
    system 'clear'
  end

  def initial_menu
    choices = ["View Subscriptions", "View Reminders", "Access User Settings", "Logout"]
    selection = @@prompt.select("What would you like to do today?", choices)
    case selection
    when "View Subscriptions" 
      # view_subscriptions
    when "Access User Settings"
      user_settings
    when "View Reminders"
      # view_reminders
    when "Logout"
      run
      system 'clear'
    end
  end

  
  
end

