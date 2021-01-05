module LoginControl
  include CliControls
  
  def login_or_signup
    choices = ["New user", "Existing User", "Quit"]
    selection = @@prompt.select("Are you a", choices)
    case selection
    when "New user" 
      handle_new_user
    when "Existing User"
      handle_existing_user
    when "Quit"
      system 'clear'
      exit
    end
  end

  ########## new user ########
  def handle_new_user
    @new_user_info = gather_new_user_data
    @user = User.create(@new_user_info)
  end

  def gather_new_user_data
      system 'clear'
      @new_user_info = new_user_input
      @repeat_password = @@prompt.mask("Re-enter your SubscriptionTracker to confirm: ", required: true, mask: @@heart)
      gather_new_user_data if !(validate_new_user_credentials == @new_user_info)
      @new_user_info
  end

  def validate_new_user_credentials
    if app_username_available?(@new_user_info[:app_username])
      return @new_user_info
    else 
      name_taken
      return false
    end
    if passwords_match?(@new_user_info[:app_password])
      return @new_user_info
    else 
      password_mismatch
      return false
    end
  end

  def name_taken
    puts "⚠️  ⚠️  This username has already been taken. Please choose a new SubscriptionTracker username ⚠️  ⚠️"
    @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    system 'clear'
  end

  def app_username_available?(username)
    User.find_by(app_username: username).nil?
  end

  def password_mismatch
    puts "⚠️  ⚠️  Passwords do not match. Please re-enter your information ⚠️  ⚠️"
    @@prompt.keypress("Press space or enter to continue", keys: [:space, :return])
    system 'clear'
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
      system 'clear'
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


end