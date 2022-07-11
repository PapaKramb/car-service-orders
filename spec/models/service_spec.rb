require 'rails_helper'

RSpec.describe Service, type: :model do
  it { should belong_to(:order) }
  it { should have_one(:executor) }
end
