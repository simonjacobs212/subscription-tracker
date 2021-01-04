class User < ActiveRecord::Base
    has_many :reminders
    has_many :subscriptions
    has_many :services, through: :subscriptions
    has_many :reminded_subscriptions, through: :reminders

    def change_name(new_first_name, new_last_name)
        self.update(first_name: new_first_name, last_name: new_last_name)
    end

    def new_subscription(service_name, email, cost, duration)
        new_service = Service.find_or_create_by(name: service_name)
        if subscription_exist?(new_service)
            puts "⚠️ ⚠️ You are already subscribed to this service, please go back and modify your existing subscription. ⚠️ ⚠️"
        else
            Subscription.create(service_id: new_service.id, email: email, user_id: self.id, cost_per_duration: cost.to_f, duration: duration.to_i)
        end
    end

    def subscription_exist?(service)
        !Subscription.find_by(user_id: self.id, service_id: service.id).nil?
    end
end
  