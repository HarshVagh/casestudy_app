require "rails_helper"

RSpec.describe "WalkIn Requests", type: :request do
  before do
    @casestudy = create(:complete_casestudy)
    @assessor = create(:assessor)
  end 

  it "GET walk_in#new" do
    get "/walk_in/casestudies/1/users/2"
    expect(response).to render_template(:new)
  end


  it "POST walk_in#create" do
    post "/walk_in/casestudies/1/users/2", params: { 
        name: "test user",
        email: "testuser@gmail.com",
        passkey: @casestudy.passkey,
        casestudy_id: @casestudy.id,
        assessor_id: @assessor.id
    } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    user = User.find_by(email: "testuser@gmail.com")
    expect(user.name).to eq("test user")
    expect(user.roles.size).to eq(1)
    expect(user.roles.first.name).to eq("candidate")
    casestudy_user = CasestudyUser.find_by(user_id: user.id)
    expect(casestudy_user.assessor_id).to eq(@assessor.id)
    expect(casestudy_user.casestudy_id).to eq(@casestudy.id)
  end
  
end