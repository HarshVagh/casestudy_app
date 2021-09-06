require "rails_helper"

RSpec.describe "UserResponses Requests", type: :request do
  before do
    @casestudy_user = create(:complete_casestudy_user)
    @user = User.find_by(name: "Candidate")
  end 

  it "GET user_responses#instructions" do
    sign_in @user
    
    get "/casestudy_users/1/instructions"
    expect(response).to render_template(:instructions)
  end

  it "GET user_responses#assessment" do
    sign_in @user
    get "/casestudy_users/1/assessment"
    expect(response).to render_template(:assessment)
    user_response = UserResponse.first
    expect(user_response.casestudy_user.id).to eq(@casestudy_user.id)
    expect(user_response.casestudy_user.status).to eq("ongoing")
    expect(user_response.response).to eq("")
  end

  it "POST user_responses#save_response" do
    sign_in @user
    user_response = create(:user_response)
    patch "/casestudy_users/1/save_response", params: { 
        user_response: { 
            id: user_response.id, 
            response: "This is final response for this question."
        } 
    } 
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
    user_response = UserResponse.first
    expect(user_response.casestudy_user).to eq(@casestudy_user)
    expect(user_response.response).to eq("This is final response for this question.")
  end

  it "GET user_responses#submit_assessment" do
    sign_in @user
    user_response = create(:user_response)
    get "/casestudy_users/1/assessment"
    get "/casestudy_users/1/submit_assessment"
    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:ok)
    @casestudy_user = CasestudyUser.find(@casestudy_user.id)
    expect(@casestudy_user.status).to eq("completed")
  end

  it "PATCH user_responses#update_time_elapsed" do
    sign_in @user
    patch "/update_time", params: { casestudy_user_id: @casestudy_user.id, time_elaspsed: 20 }
    expect(response).to have_http_status(:ok)
    @casestudy_user = CasestudyUser.find(@casestudy_user.id)
    expect(@casestudy_user.time_elaspsed).to eq(20)
  end


  
end