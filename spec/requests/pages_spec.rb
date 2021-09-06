require "rails_helper"

RSpec.describe "Pages Requests", type: :request do
  before do
    @user = create(:contentcreator)
    @casestudy = create(:casestudy)
  end 

  it "GET pages#index" do
    sign_in @user
    create(:page)
    get "/casestudies/1/pages"
    expect(response).to render_template(:index)
  end

  it "GET pages#new" do
    sign_in @user
    get "/casestudies/1/pages/new"
    expect(response).to render_template(:new)
  end

  it "GET pages#edit" do
    sign_in @user
    create(:page)
    get "/casestudies/1/pages/1/edit"
    expect(response).to render_template(:edit)
  end

  it "GET pages#show" do
    sign_in @user
    create(:page)
    get "/casestudies/1/pages/1"
    expect(response).to render_template(:show)
  end

  it "POST pages#create" do
    sign_in @user
    post "/casestudies/1/pages", params: { page: { body: "This is body of a page in casestudy." } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    page = Page.first
    expect(page.body).to eq("This is body of a page in casestudy.")
    expect(page.casestudy).to eq(@casestudy)
  end

  it "PUT pages#update" do
    sign_in @user
    create(:page)
    put "/casestudies/1/pages/1", params: { page: { body: "This is (edited) body of a page in casestudy." } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    page = Page.first
    expect(page.body).to eq("This is (edited) body of a page in casestudy.")
  end

  it "DELETE pages#destroy" do
    sign_in @user
    create(:page)
    delete "/casestudies/1/pages/1"
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(Page.all.exists?(1)).to eq(false)
  end
  
end