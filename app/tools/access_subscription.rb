require_all 'app/tools'

module AccessSubscriptions
  include CliControls
  include LoginControl

  def access_subscriptions
    system 'clear'
    subscriptions_action_selection

  end

  def subscriptions_action_selection
    choices = ["View all subcriptions", "Change SubscriptionTracker Password", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do?", choices)
    case selection
    when "View all subcriptions"
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

  



end