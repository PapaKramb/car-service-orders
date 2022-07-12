require 'rails_helper'

RSpec.describe Executor, type: :model do
  it { should belong_to(:service) }
  it { should validate_presence_of :name }
end
