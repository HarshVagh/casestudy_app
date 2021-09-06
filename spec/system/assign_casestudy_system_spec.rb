require "rails_helper"

RSpec.describe "Assign Casestudy System" do
    
    before do
        driven_by(:rack_test)
        @user = create(:contentcreator)
        @assessor = create(:assessor)
        @candidate = create(:candidate)
        @casestudy = create(:casestudy)
    end

    it "assigns casestudy to users" do
        sign_in @user
        visit "/contentcreator_dashboard"
        click_on "Assign Casestudy"
        expect(page).to have_current_path("/casestudy_users/new")

        find(:select, name: "casestudy_user[user_id]").find(:option, @candidate.name).select_option
        find(:select, name: "casestudy_user[assessor_id]").find(:option, @assessor.name).select_option
        find(:select, name: "casestudy_user[casestudy_id]").find(:option, @casestudy.name).select_option
        click_on "Assign"

        casestudy_user = CasestudyUser.first
        expect(casestudy_user.user_id).to eq(3)
        expect(casestudy_user.assessor_id).to eq(2)
        expect(casestudy_user.casestudy_id).to eq(1)

        expect(page).to have_current_path("/casestudy_users/new")
        click_on "Back"
        expect(page).to have_current_path("/contentcreator_dashboard")
    end
    
end