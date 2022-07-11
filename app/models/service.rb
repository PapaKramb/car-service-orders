class Service < ApplicationRecord
  belongs_to :order
  has_one :executor
  has_many :categories, dependent: :destroy
end
