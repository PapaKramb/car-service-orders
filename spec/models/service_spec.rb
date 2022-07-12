require 'rails_helper'

RSpec.describe Service, type: :model do
  it { should have_many(:orders) }
  it { should have_one(:executor) }
  it { should have_many(:categories) }

  it { should validate_presence_of :service_name }
end
