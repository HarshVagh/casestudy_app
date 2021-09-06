require "rails_helper"

RSpec.describe "Questions Requests", type: :request do
  before do
    @user = create(:contentcreator)
    @casestudy = create(:casestudy)
  end 

  it "GET questions#index" do
    sign_in @user
    create(:question)
    get "/casestudies/1/questions"
    expect(response).to render_template(:index)
  end

  it "GET questions#new" do
    sign_in @user
    get "/casestudies/1/questions/new"
    expect(response).to render_template(:new)
  end

  it "GET questions#edit" do
    sign_in @user
    create(:question)
    get "/casestudies/1/questions/1/edit"
    expect(response).to render_template(:edit)
  end

  it "GET questions#show" do
    sign_in @user
    create(:question)
    get "/casestudies/1/questions/1"
    expect(response).to render_template(:show)
  end

  it "POST questions#create" do
    sign_in @user
    post "/casestudies/1/questions", params: { question: { body: "This is body of a question in casestudy." } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    question = Question.first
    expect(question.body).to eq("This is body of a question in casestudy.")
    expect(question.casestudy).to eq(@casestudy)
  end

  it "PUT questions#update" do
    sign_in @user
    create(:question)
    put "/casestudies/1/questions/1", params: { question: { body: "This is (edited) body of a question in casestudy." } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    question = Question.first
    expect(question.body).to eq("This is (edited) body of a question in casestudy.")
  end

  it "DELETE questions#destroy" do
    sign_in @user
    create(:question)
    delete "/casestudies/1/questions/1"
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(Question.all.exists?(1)).to eq(false)
  end
  
end