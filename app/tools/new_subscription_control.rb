require_all 'app/tools'

module NewSubscriptionControl
  include CliControls

  def add_new_subscription
    system 'clear'
    @service = pick_service
    new_subscription_info_hash = @@prompt.collect do
      key(:email).ask("\nWhat email address did you use to sign up for this service?") do |response| 
        response.validate(/\A\w+@\w+\.\w+\Z/)
        response.messages[:valid?] = "Invalid email address. Please try again."
      end
      key(:duration).ask("How many days is this subscription plan for? (1 month = 30, 1 year = 365) ", convert: :int) do |response|
        response.validate(/\b[1-9]\d{0,2}\b/)
        response.messages[:valid?] = "Invalid duration. Please enter a plan duration between 1 and 365."
      end
      key(:cost_per_duration).ask("What is the cost of your subscription plan? (If this is a free trial, enter 0.00) ", convert: :float) do |response| 
        response.validate(/((\A\d{1,4}\.\d{2}\Z)|(\A\d{1,4}\Z))/)
        response.messages[:valid?] = "Invalid cost. Please enter a cost between 0.00 and 9999.99."
      end
    end
    new_subscription_info_hash[:service_id] = @service.id
    new_subscription_info_hash[:user_id] = @user.id
    @subscription = Subscription.create(new_subscription_info_hash)
    set_custom_start_date if set_custom_start_date?
    create_reminder_and_file if set_reminder?
    access_subscriptions
  end

  def pick_service
    choices = Service.create_service_menu_choices
    @@prompt.select("Which service did you subscribe to? (Begin typing the name to filter results)\n----------------------------------------------------------------------------\n", choices, filter: true)
  end

  def set_reminder?
    puts "\n"
    yes_no("Would you like to set a reminder for this subscription?")
  end

  def set_custom_start_date?
    puts "\n"
    !yes_no("Does this subscription start today?")
  end

  def set_custom_start_date
    @date_hash = get_date_info
    new_date = convert_date_hash_to_date
    @subscription.set_start_date(new_date)
    @subscription.custom_renewal_date
  end

  def convert_date_hash_to_date
    @date_hash.values.join(" ").to_date
  end

  def get_date_info
    months = Date::MONTHNAMES[1..12]
    days = (1..31).to_a
    @@prompt.collect do
      key(:month).select("Please select the month in which the subscription started", months, required: true, filter: true)
      key(:day).select("Please select the date on which the subscription started: ", days, required: true, filter: true)
      key(:year).ask("Please enter the year which when the subscription plan began", required: true) do |response|
        response.validate(/\A[1,2][0,9]\d{2}\Z/)
        response.messages[:valid?] = "Invalid year. Please enter a year from 1900 - present."
      end
    end
  end


end
