module LoginControl
  include CliControls
  
  def login_or_signup
    choices = ["New user", "Existing User", "Quit"]
    selection = @@prompt.select("Are you a: ", choices)
    case selection
    when "New user" 
      handle_new_user
    when "Existing User"
      handle_existing_user
    when "Quit"
      logout
      exit
    end
  end

  ########## new user ########
  def handle_new_user
    @new_user_info = gather_new_user_data
    @user = User.create(@new_user_info)
    budget_handler if create_budget?
    @user
  end

  def gather_new_user_data
      custom_clear
      @new_user_info = new_user_input
      @repeat_password = @@prompt.mask("Re-enter your SubscriptionTracker to confirm: ", required: true, mask: @@heart)
      gather_new_user_data if !(validate_new_user_credentials == self.new_user_info)
      @new_user_info
  end

  def validate_new_user_credentials
      app_username_available?(@new_user_info[:app_username]) ? self.new_user_info : name_taken
      passwords_match?(@new_user_info[:app_password]) ? self.new_user_info : password_mismatch
  end

  def name_taken
    puts "⚠️  ⚠️  This username has already been taken. Please choose a new SubscriptionTracker username ⚠️  ⚠️".yellow
    play_warning_sound
    @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    custom_clear
    return false
  end

  def app_username_available?(username)
    User.find_by(app_username: username).nil?
  end

  def password_mismatch
    puts "⚠️  ⚠️  Passwords do not match. Please re-enter your information ⚠️  ⚠️".yellow
    play_warning_sound
    @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    custom_clear
    return false
  end

  def new_user_input
    @@prompt.collect do
      key(:first_name).ask("First Name? ", required: true) { |q| q.modify :down}
      key(:last_name).ask("Last Name? ", required: true) { |q| q.modify :down}
      key(:app_username).ask("Create your username for SubscriptionTracker: ", required: true) { |q| q.modify :down}
      key(:app_password).mask("Create a password to access you SubscriptionTracker account: ", required: true, mask: @@heart)
    end
  end

  def passwords_match?(password)
    password == @repeat_password
  end

######### existing user ########

  def handle_existing_user
    @user = gather_existing_data
  end

  def gather_existing_data
    while 0==0 
      custom_clear
      @user = find_user
      return @user if !@user.nil?
      puts "User not found or password incorrect"
      return run if !yes_no("Would you like to try again?")
    end
  end

  def existing_user_input
    @@prompt.collect do
      key(:app_username).ask("Please enter your SubscriptionTracker username: ", required: true) { |q| q.modify :down}
      key(:app_password).mask("Please enter your SubscriptionTracker password: ", required: true, mask: @@heart)
    end
  end

  def find_user
    existing_user_info = existing_user_input
    @user = User.find_by(existing_user_info)
  end

  #### budget new user #####

  def create_budget?
    yes_no("Would you like to set a budget to help analyze your spending?")
  end

  def get_budget_amount
      @@prompt.ask("What is your monthly budget for subscription services? $", require: true, convert: :float) do |response| 
          response.validate(/((\A\d{1,4}\.\d{2}\Z)|(\A\d{1,4}\Z))/)
          response.messages[:valid?] = "Invalid cost. Please enter a cost between 0.00 and 9999.99."
      end
  end

  def budget_handler
    @user.display_current_budget if @user.has_budget?
    budget = get_budget_amount
    @user.set_budget(budget)
    puts "✅ Your budget has been updated!".green
    play_single_coin
    custom_clear
  end

end