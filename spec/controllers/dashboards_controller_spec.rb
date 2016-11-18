require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  render_views

  let(:user) { FactoryGirl.create(:user, :admin) }
end
