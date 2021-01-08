class SubscriptionTracker
  include UserSettings
  include AccessSubscriptions
  include SpendingAnalyzer
  

  attr_accessor :new_user_info
  
  def run
    welcome
    @user = login_or_signup
    say_hi_to_user
    display_active_reminders_for_user if !@user.upcoming_renewals.empty?
    main_menu    
  end

  private
  
  def welcome
    custom_clear
    display_logo
    puts "Welcome to SubscriptionTracker!\n".light_green
    sleep(0.3)
  end

  def say_hi_to_user   
    custom_clear
    puts "Welcome #{@user.first_name.capitalize}!".light_blue
    puts "\n" 
    sleep(0.3)
  end

  def display_active_reminders_for_user
    puts "\n"
    @user.display_upcoming_renewals
    @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    custom_clear
  end

  def main_menu
    choices = ["My Subscriptions", "Access User Settings", "Spending Summary", "Logout"]
    selection = @@prompt.select("What would you like to do today?", choices)
    case selection
    when "My Subscriptions" 
      access_subscriptions
    when "Access User Settings"
      user_settings
    when "Spending Summary"
      spending_summary
    when "Logout"
      custom_clear
      run
    end
  end

end

