require "rails_helper"

RSpec.describe "CasestudyUsers Requests", type: :request do
  before do
    @casestudy = create(:complete_casestudy)
    @creator = User.first
    @assessor = create(:assessor)
    @candidate = create(:candidate)
  end 

  it "GET casestudy_users#index" do
    sign_in @creator
    get "/casestudy_users"
    expect(response).to render_template(:index)
  end

  it "GET casestudy_users#new" do
    sign_in @creator
    get "/casestudy_users/new"
    expect(response).to render_template(:new)
  end

  it "POST casestudy_users#create" do
    sign_in @creator
    post "/casestudy_users", params: { 
        casestudy_user: { 
            user_id: @candidate.id, 
            assessor_id: @assessor.id, 
            casestudy_id: @casestudy.id 
        } 
    } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    casestudy_user = CasestudyUser.first
    expect(casestudy_user.status).to eq("pending")
    expect(casestudy_user.time_elaspsed).to eq(0)
    expect(casestudy_user.user).to eq(@candidate)
    expect(casestudy_user.assessor).to eq(@assessor)
    expect(casestudy_user.casestudy).to eq(@casestudy)
  end
  
end