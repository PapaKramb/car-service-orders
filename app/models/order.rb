class Order < ApplicationRecord
  has_many :services, dependent: :destroy
  validates :customers_name, presence: true
end
