require_all 'app/tools'

module NewSubscriptionControl
  include CliControls

  def add_new_subscription
    system 'clear'
    @service = pick_service
    new_subscription_info_hash = @@prompt.collect do
      key(:email).ask("What email address did you use to sign up for this service?") do |response| 
        response.validate(/\A\w+@\w+\.\w+\Z/)
        response.messages[:valid?] = "Invalid email address. Please try again."
      end
      # key(:duration).ask("How many days in this subscription for? (1 month = 30, 1 year = 365)") do |response|
      #   response.validate(/\b[1-9]\d{0,2}\b/)
      #   response.messages[:valid?] = "Invalid duration. Please enter a plan duration between 1 and 365."
      #   response.to_i
      # end
      # key(:cost_per_duration).ask("What is the cost of your plan for the duration you provided? ") do |response| 
      #   response.to_s.validate(/\A\d{1,4}\.\d{2}/)
      #   response.messages[:valid?] = "Invalid cost. Please enter a cost between 0.00 and 9999.99."
      #   response.to_f
      # end
    end
    new_subscription_info_hash[service_id: @service.id, user_id: @user.id]
    binding.pry
    Subscription.create(new_subscription_info_hash)
  end

  def pick_service
    choices = Service.create_service_menu_choices
    @@prompt.select("Which service's subscription would like to add to track?\n-------------------------------------------------\n", choices)
  end

end
