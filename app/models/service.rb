class Service < ApplicationRecord
  has_many :orders
  has_one :executor
  has_many :categories

  validates :service_name, presence: true
end
