require 'rails_helper'

RSpec.describe Weight, type: :model do
  it { should validate_presence_of(:value) }
end
