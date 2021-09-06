require "rails_helper"

RSpec.describe "QuestionTraits Requests", type: :request do
  before do
    @user = create(:contentcreator)
    @casestudy = create(:casestudy)
  end 

  it "GET question_traits#new" do
    @question = create(:question)
    sign_in @user
    get "/casestudies/1/questions/1/question_traits/new"
    expect(response).to render_template(:new)
  end

  it "POST question_traits#create" do
    sign_in @user
    @question = create(:question)
    @trait = create(:trait1)
    post "/casestudies/1/questions/1/question_traits", params: { trait: { trait_id: 1 } } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    question_trait = QuestionTrait.first
    expect(question_trait.question).to eq(@question)
    expect(question_trait.trait).to eq(@trait)
  end

  it "DELETE question_traits#destroy" do
    sign_in @user
    create(:question1)
    delete "/casestudies/1/questions/1/question_traits/1"
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(QuestionTrait.all.exists?(1)).to eq(false)
  end
  
end