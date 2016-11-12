require 'rails_helper'

RSpec.describe InkUsagesController, type: :controller do
  context 'logged in' do
    let(:user) { FactoryGirl.create(:user, :admin) }

    before (:each) do
      sign_in user
    end
  end
end
