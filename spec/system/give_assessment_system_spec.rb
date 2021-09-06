require "rails_helper"

RSpec.describe "Give Assessment System" do
    before do
        driven_by(:rack_test)
        create(:complete_casestudy)
        create(:assessor)
        @candidate = create(:candidate)
        create(:casestudy_user)
        
    end

    it "gives an assessment" do
        
        sign_in @candidate
        visit "/candidate_dashboard"

        click_on "Show Assessments"

        expect(page).to have_current_path("/casestudy_users")
        
        click_on "Start"

        expect(page).to have_current_path("/casestudy_users/1/instructions")

        click_on "Start Assessment"

        expect(page).to have_current_path("/casestudy_users/1/assessment")

        fill_in "user_response[response]", with: "This is answer for question 01.", match: :first
        click_on "Save", match: :first
        expect(page).to have_current_path("/casestudy_users/1/assessment")
        @user_response1 = UserResponse.first
        expect(@user_response1.casestudy_user_id).to eq(1)
        expect(@user_response1.question_id).to eq(1)
        expect(@user_response1.user_id).to eq(@candidate.id)
        expect(@user_response1.response).to eq("This is answer for question 01.")

        click_on "Finish Assessment"

        expect(page).to have_current_path("/casestudy_users/1/submit_assessment")

        click_on "Finish"

        expect(page).to have_current_path("/candidate_dashboard")

        
    end
    
    
end
