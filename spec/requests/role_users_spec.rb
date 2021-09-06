require "rails_helper"

RSpec.describe "RoleUsers Requests", type: :request do
  before do
    @user = create(:contentcreator)
  end 

  it "GET role_users#new" do
    sign_in @user
    get "/role_users/new"
    expect(response).to render_template(:new)
  end

  it "POST role_users#create" do
    sign_in @user
    candidate = create(:candidate)
    creator_role = Role.find_by(name: "contentcreator")
    post "/role_users", params: { role_user: { user_id: candidate.id, role_id: creator_role.id  } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(candidate.roles.exists?(creator_role.id)).to eq(true)
  end
  
end