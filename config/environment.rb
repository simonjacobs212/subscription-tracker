require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil

require_relative '../app/tools/cli_controls.rb'
require_relative '../app/tools/fonts.rb'
require_relative '../app/tools/icalendar.rb'
require_relative '../app/tools/login_control.rb'
require_relative '../app/tools/new_subscription_control.rb'
require_relative '../app/tools/update_subscription_handler.rb'
require_relative '../app/tools/spending_analyzer.rb'
require_relative '../app/tools/access_subscriptions.rb'
require_relative '../app/tools/user_settings.rb'

require_all 'app'

