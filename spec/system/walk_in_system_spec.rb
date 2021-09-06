require "rails_helper"

RSpec.describe "Casestudy System", type: :system do
    
    before do
        driven_by(:rack_test)
        @casestudy = create(:complete_casestudy)
        @assessor = create(:assessor)
    end

    it "walk in new user to an assessment" do
        visit "walk_in/casestudies/#{@casestudy.id}/users/#{@assessor.id}"
        fill_in "name", with: "test candidate" 
        fill_in "email", with: "testcandidate@gmail.com" 
        fill_in "passkey", with: "12341234"

        click_on "Next"
        
        user = User.find_by(email: "testcandidate@gmail.com")
        expect(user.name).to eq("test candidate")
        expect(user.email).to eq("testcandidate@gmail.com")
        expect(user.roles.size).to eq(1)
        expect(user.roles.first.name).to eq("candidate")
        casestudy_user = CasestudyUser.find_by(user_id: user.id)
        expect(casestudy_user.assessor_id).to eq(@assessor.id)
        expect(casestudy_user.casestudy_id).to eq(@casestudy.id)

        expect(page).to have_current_path("/casestudy_users/1/instructions")

    end

end