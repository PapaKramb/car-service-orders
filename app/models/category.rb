class Category < ApplicationRecord
  belongs_to :service
  validates :category_name, presence: true
end
