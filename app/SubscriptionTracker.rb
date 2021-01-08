require_relative 'tools/funstuff'

class SubscriptionTracker
  include UserSettings
  include AccessSubscriptions
  include SpendingAnalyzer
  include FunStuff

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
    display_logo
    puts "Welcome to SubscriptionTracker!"
    sleep(0.3)
  end

  def say_hi_to_user   
    system 'clear'
    puts "Welcome #{@user.first_name.capitalize}!"
    puts "\n" 
  end

  def display_active_reminders_for_user
    puts "\n"
    @user.display_upcoming_renewals
    @@prompt.keypress("Press space or enter to return to Main Menu", keys: [:space, :return])
    system 'clear'
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
      system 'clear'
      run
    end
  end

end

