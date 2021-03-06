module UpdateSubscriptionHandler 
  include CliControls

  def update_subscription_handler
    puts @subscription.display_subscription_info
    update_subscription
  end

  def update_subscription
    choices = ["Update cost/duration", "Delete Subscription", "Back", "Logout"]
    selection = @@prompt.select("What would you like to do for the subscription above? ", choices)
    case selection
    when "Update cost/duration"
      update_subcription_info
      disable_old_reminder if @subscription.reminder_exists?
      create_reminder_and_file if want_new_reminder? 
      access_subscriptions
    when "Delete Subscription"
      delete_subscription_and_sound if confirm_delete?
      access_subscriptions
    when "Back"
      custom_clear
      access_subscriptions
    when "Logout"
      custom_clear
      run
    end
  end

  def delete_subscription_and_sound
    @subscription.delete_subscription 
    play_explosion 
  end

  def update_subcription_info
    new_sub_info = @@prompt.collect do
      key(:duration).ask("How many days in this subscription for? (1 month = 30, 1 year = 365) ", convert: :int) do |response|
        response.validate(/\b[1-9]\d{0,2}\b/)
        response.messages[:valid?] = "Invalid duration. Please enter a plan duration between 1 and 365."
      end
      key(:cost_per_duration).ask("What is the cost of your subscription plan? (If this is a free trial, enter 0.00) $", convert: :float) do |response| 
        response.validate(/((\A\d{1,4}\.\d{2}\Z)|(\A\d{1,4}\Z))/)
        response.messages[:valid?] = "Invalid cost. Please enter a cost between 0.00 and 9999.99."
      end
    end
      @subscription.update(new_sub_info)
      @subscription.update_renewal_date
      puts "✅ Your subscription information has been updated".green
      sleep (1.5)
  end

  def disable_old_reminder
    @subscription.disable_reminder_for_subscription
  end

  def want_new_reminder?
    play_warning_sound
    yes_no("⚠️ Would you like to set a reminder for this updated subscription? ⚠️\n⚠️ If you previously had a reminder, it has been disabled ⚠️".yellow)
  end

  def confirm_delete?
    play_warning_sound
    yes_no("⚠️ Are you sure you want to delete this subscription? This action cannot be undone. ⚠️".yellow)
  end

end