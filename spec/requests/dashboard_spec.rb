require "rails_helper"

RSpec.describe "Dashboard Requests", type: :request do
    
  it "GET dashboard#candidate_dashboard" do
    candidate = create(:candidate)
    sign_in candidate
    get "/candidate_dashboard"
    expect(response).to render_template(:candidate_dashboard)
  end

  it "GET dashboard#assessor_dashboard" do
    assessor = create(:assessor)
    sign_in assessor
    get "/assessor_dashboard"
    expect(response).to render_template(:assessor_dashboard)
  end

  it "GET dashboard#contentcreator_dashboard" do
    contentcreator = create(:contentcreator)
    sign_in contentcreator
    get "/contentcreator_dashboard"
    expect(response).to render_template(:contentcreator_dashboard)
  end
  
end