require "rails_helper"

RSpec.describe "Casestudies Requests", type: :request do
  before do
    @user = create(:contentcreator)
  end 

  it "GET casestudies#index" do
    sign_in @user
    get "/casestudies"
    expect(response).to render_template(:index)
  end

  it "GET casestudies#new" do
    sign_in @user
    get "/casestudies/new"
    expect(response).to render_template(:new)
  end

  it "GET casestudies#edit" do
    sign_in @user
    create(:casestudy)
    get "/casestudies/1/edit"
    expect(response).to render_template(:edit)
  end

  it "GET casestudies#show" do
    sign_in @user
    create(:casestudy)
    get "/casestudies/1"
    expect(response).to render_template(:show)
  end

  it "POST casestudies#create" do
    sign_in @user
    post "/casestudies", params: { 
      casestudy: {
        name: "casestudy01",
        duration: 90,
        scale: 8,
        contentcreator_id: 1,
        passkey: "12341234"
      }
    } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    casestudy = Casestudy.first
    expect(casestudy.name).to eq("casestudy01")
    expect(casestudy.duration).to eq(90)
    expect(casestudy.scale).to eq(8)
    expect(casestudy.contentcreator).to eq(@user)
    expect(casestudy.passkey).to eq("12341234")
  end

  it "PUT casestudies#update" do
    sign_in @user
    create(:casestudy)
    put "/casestudies/1", params: { 
      casestudy: {
        name: "Case-Study-01",
        duration: 120,
        scale: 10,
        contentcreator_id: 1,
        passkey: "12341234"
      }
    }
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    casestudy = Casestudy.first
    expect(casestudy.name).to eq("Case-Study-01")
    expect(casestudy.duration).to eq(120)
    expect(casestudy.scale).to eq(10)
  end

  
end