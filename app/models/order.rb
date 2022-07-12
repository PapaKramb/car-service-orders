class Order < ApplicationRecord
  has_many :services, dependent: :destroy
end
