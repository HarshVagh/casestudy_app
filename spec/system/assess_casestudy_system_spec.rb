require "rails_helper"

RSpec.describe "Assess Casestudy System", type: :system do
    
    before do
        driven_by(:rack_test)
        create(:complete_casestudy_user, status: "completed")
        @assessor = User.find_by(name: "Assessor")
        create(:user_response)
        create(:user_response, question_id: 2)
    end

    it "assess a casestudy" do
        sign_in @assessor
        visit "/assessor/#{@assessor.id}/assessments"
        click_on "Assess"

        expect(page).to have_current_path("/assessor/casestudy_user/1")
        expect(AssessorResponse.all.size).to eq(2)
        
        fill_in "assessor_response[rating]", with: 3.6, match: :first
        click_on "Save", match: :first
        expect(page).to have_current_path("/assessor/casestudy_user/1")
        assessor_response = AssessorResponse.first
        expect(assessor_response.rating).to eq(3.6)

        click_on "Submit"
        expect(page).to have_current_path("/assessor/#{@assessor.id}/assessments")

        assessor_response = AssessorResponse.first
        expect(assessor_response.casestudy_user.status).to eq("assessed")

    end

end