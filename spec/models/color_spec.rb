require 'rails_helper'

RSpec.describe Color, type: :model do
  it { should have_many :part_numbers }
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
