require 'rails_helper'

RSpec.describe InkUsage, type: :model do
  describe 'Class methods' do
    before(:each) do
      10.times { FactoryGirl.create(:ink_usage) }
    end

    describe 'exp_code_since scope' do
      subject { described_class.exp_code_since Date.today }
      let(:ink_usages) {
        10.times { FactoryGirl.create(:ink_usage, exp_code: 10.days.ago) }
        described_class.all.select { |ink_usage| ink_usage.exp_code >= Date.today }
      }

      it 'returns all ink_usages exp_code since today' do
        expect(subject).to contain_exactly *ink_usages
      end
    end

    describe 'created_on scope' do
      subject { described_class.created_on Date.today }

      let(:ink_usages) {
        FactoryGirl.create(:ink_usage, created_at: 10.days.ago, updated_at: 10.days.ago)
        described_class.all.select { |ink_usage| ink_usage.created_at.to_date == Date.today.to_date }
      }

      it 'returns ink_usages created_on today' do
        expect(subject).to contain_exactly *ink_usages
      end
    end

    describe 'for_machine' do
      subject { described_class.for_machine Machine.last }

      let(:ink_usages) {
        described_class.joins(:machine_part_number).where(machine_part_numbers: { machine_id: Machine.last.id })
      }

      it 'returns ink_usages on the last machine' do
        expect(subject).to contain_exactly *ink_usages
      end
    end
  end
end
