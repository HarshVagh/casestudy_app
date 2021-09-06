require "rails_helper"

RSpec.describe "Traits Requests", type: :request do
  before do
    @user = create(:contentcreator)
  end 

  it "GET traits#new" do
    sign_in @user
    get "/traits/new"
    expect(response).to render_template(:new)
  end


  it "POST traits#create" do
    sign_in @user
    post "/traits", params: { trait: { name: "Trait01" } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(Trait.first.name).to eq("Trait01")
  end
  
end