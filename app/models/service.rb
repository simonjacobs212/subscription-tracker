class Service < ActiveRecord::Base
  has_many :service_categories
  has_many :categories, through: :service_categories
  has_many :subscriptions
  has_many :reminders, through: :subscriptions
  has_many :users, through: :subscriptions


  def add_category_to_service(category_array)
    self.categories << category_array
  end

  def self.create_service_menu_choices
    self.all.each_with_object({}) do |service, new_hash|
      new_hash[service.name] = service
    end
  end

end
