class Category < ActiveRecord::Base
    has_many :service_categories
    has_many :services, through: :service_categories
end
