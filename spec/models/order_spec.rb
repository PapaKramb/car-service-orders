require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:service) }
  it { should validate_presence_of :customers_name }
end
