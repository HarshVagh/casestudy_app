require "rails_helper"

RSpec.describe "AssessorResponses Requests", type: :request do
  before do
    @casestudy_user = create(:complete_casestudy_user)
    @casestudy_user.update(status: "completed")
    create(:user_response)
    create(:user_response, question_id: 2)
    @assessor = User.find_by(name: "Assessor")
  end 

  it "GET assessor_responses#index" do
    sign_in @assessor
    
    get "/assessor/#{@assessor.id}/assessments"
    expect(response).to render_template(:index)
  end

  it "GET assessor_responses#assess" do
    sign_in @assessor
    get "/assessor/casestudy_user/1"
    expect(response).to render_template(:assess)
    assessor_response = AssessorResponse.first
    expect(assessor_response.casestudy_user_id).to eq(@casestudy_user.id)
    expect(assessor_response.question_trait_id).to eq(1)
    expect(assessor_response.user_id).to eq(@casestudy_user.user_id)
    expect(assessor_response.assessor_id).to eq(@assessor.id)
    expect(assessor_response.rating).to eq(0)
  end

  it "POST assessor_responses#show" do
    sign_in @assessor
    get "/assessor/casestudy_user/1/show"
    expect(response).to render_template(:show)
  end

  it "PATCH assessor_responses#update_rating" do
    sign_in @assessor
    get "/assessor/casestudy_user/1"
    patch "/assessor/casestudy_user/#{@casestudy_user.id}/update", params: { 
        casestudy_user_id: @casestudy_user.id, 
        assessor_response: { 
            question_trait_id: 1, 
            rating: 2.4
        } 
    }
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    assessor_response = AssessorResponse.first
    expect(assessor_response.rating).to eq(2.4)
  end

  it "GET assessor_responses#submit_assessment" do
    sign_in @assessor
    assessor_response = create(:assessor_response)
    get "/assessor/casestudy_user/1/submit"
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    expect(CasestudyUser.first.status).to eq("assessed")
  end

  


  
end