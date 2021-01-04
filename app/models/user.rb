class User < ActiveRecord::Base
    has_many :reminders
    has_many :subscriptions
    has_many :services, through: :subscriptions

    def change_name(new_first_name, new_last_name)
        self.update(first_name: new_first_name, last_name: new_last_name)
    end

    def new_subscription(service_name, email, cost, duration)
        if subscription_exist?(new_service)
            puts "⚠️ ⚠️ You are already subscribed to this service, please go back and modify your existing subscription. ⚠️ ⚠️"
        else
            Subscription.create(service_id: new_service.id, email: email, user_id: self.id, cost_per_duration: cost.to_f, duration: duration.to_i)
        end
    end

    def subscription_exist?(service)
        !Subscription.find_by(user_id: self.id, service_id: service.id).nil?
    end

    def display_subscriptions
        self.subscriptions.each do |subscription|
            puts "Service Name: #{subscription.service.name.capitalize}"
            puts "Cost per #{subscription.duration} days: $#{subscription.cost_per_duration}"
            puts "Days until expiration: #{subscription.days_remaining}"
            puts "----------------------------------"
        end
    end

    def delete_user
        self.destroy
    end

    def new_service(service_name, url)
        Service.find_or_create_by(name: service_name, url: url)
    end

    def display_reminders
        self.subscriptions.each do |subscription|
            next if subscription.active_reminder.nil?
            puts "Service Name: #{subscription.service.name.capitalize}"
            puts "Expiration reminder will be sent on: #{subscription.active_reminder.reminder_date.to_date}"
            puts "-----------------------------------------------------"
        end
    end


end