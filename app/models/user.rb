class User < ActiveRecord::Base
    has_many :reminders
    has_many :subscriptions
    has_many :services, through: :subscriptions

    def change_name(new_first_name, new_last_name)
        self.update(first_name: new_first_name, last_name: new_last_name)
    end

    def daily_spending_by_category
        total = self.subscriptions.each_with_object({}) do |subscription, total|
            inner_hash = subscription.service.categories.group(:name).sum(subscription.normalize_cost)
                inner_hash.each do |category, cost|
                    total[category].nil? ? total[category] = cost : total[category] += cost
                end
            end
    end

    def subscription_exist?(service)
        !Subscription.find_by(user_id: self.id, service_id: service.id).nil?
    end

    def delete_user
        self.destroy
    end

    def display_reminders
        self.subscriptions.reload.each do |subscription|
            next if subscription.active_reminder.nil?
            subscription.display_active_reminder
        end
    end

    def display_upcoming_renewals
        self.upcoming_renewals.each do |subscription|
            puts "Service Name: "+"#{subscription.service.name}".light_blue
            puts "Will expire on: "+"#{subscription.renewal_date.strftime("%b %d %Y")}".light_blue
            puts "------------------------------"
            puts "\n"
        end
    end

    def active_reminders
        self.subscriptions.reload.select {|subscription| !subscription.active_reminder.nil?}
    end

    def upcoming_renewals
        self.active_reminders.select do |subscription|
            DateTime.now > subscription.active_reminder.reminder_date
        end
    end

    def create_subscription_menu_choices
        self.subscriptions.reload.each_with_object({}) do |subscription, new_hash|
            new_hash[subscription.display_subscription_info] = subscription
        end
    end

####################################### MVP + METHODS ###########################################

    def print_app_login_info
        puts "Current SubscriptionTracker Credentials:"
        puts "--------------------------------------------"
        puts "Username: " +"#{self.app_username}".light_blue
        puts "Password: " +"#{self.app_password}".light_blue
        if self.has_budget?
            puts "Current Budget: " +"$#{sprintf('%.2f', self.budget)}".light_blue
        end
        puts "--------------------------------------------"
    end

    def display_full_name
        "#{self.first_name.capitalize} #{self.last_name.capitalize}".light_blue
    end

    def change_app_password(new_password)
        self.update(app_password: new_password)
    end

    def change_app_username(new_username)
        self.update(app_username: new_username)
    end

    def spending_per_day
        self.subscriptions.sum do |subscription|
            subscription.normalize_cost
        end
    end

    def spending_per_month
        self.spending_per_day * 30
    end 

    def spending_per_year
        self.spending_per_day * 365
    end

    def most_expensive_subscription
        self.subscriptions.max do |subscription|
            subscription.normalize_cost
        end
    end

    def create_user_directory
        Dir.mkdir "reminder_files" if !Dir.exists? "reminder_files"
        Dir.mkdir "reminder_files/#{self.app_username}" if !Dir.exists? "reminder_files/#{self.app_username}"
    end

    def delete_user_files
        system 'rm','-rf',"reminder_files/#{self.app_username}" if Dir.exists? "reminder_files/#{self.app_username}"
    end

    def has_budget?
        !self.budget.nil?
    end

    def set_budget(value)
        self.update(budget: value)
    end

    def display_current_budget
        system 'clear'
        puts "------------------------"
        puts "Current Budget: " +"$#{sprintf('%.2f', self.budget)}".light_blue
        puts "------------------------"
    end

    def over_budget?
        self.spending_per_month.round(2) > self.budget
    end

    def spending_difference
        (self.budget - self.spending_per_month.round(2)).abs
    end

    def over_budget_alert
        "You are currently exceeding your monthly budget of "+ "$#{sprintf('%.2f', self.budget)}".red + "\n" +
        "You are overspending by "+ "$#{sprintf('%.2f', self.spending_difference)}".red
    end

    def under_budget_alert
        "You are currently under your monthly budget of "+ "$#{sprintf('%.2f', self.budget)}".light_green + "\n" +
        "You are underspending by "+ "$#{sprintf('%.2f', self.spending_difference)}".light_green
    end

    def budget_alerts
        if self.over_budget? 
            puts self.over_budget_alert
        else 
            puts self.under_budget_alert
        end
    end

end