class Order < ApplicationRecord
  belongs_to :service
  validates :customers_name, presence: true
end
