require "rails_helper"

RSpec.describe "Assign User Role System" do
    
    before do
        driven_by(:rack_test)
        @user = create(:contentcreator)
        @assessor = create(:assessor)
        @candidate = create(:candidate)
    end

    it "assigns role to users" do
        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Assign Roles"
        expect(page).to have_current_path("/role_users/new")

        find(:select, name: "role_user[user_id]").find(:option, @candidate.name).select_option
        find(:select, name: "role_user[role_id]").find(:option, "assessor").select_option
        click_on "Assign"

        expect(@candidate.roles.exists?(name: "assessor")).to eq(true)
        expect(page).to have_current_path("/role_users/new")

        find(:select, name: "role_user[user_id]").find(:option, @assessor.name).select_option
        find(:select, name: "role_user[role_id]").find(:option, "contentcreator").select_option
        click_on "Assign"

        expect(@assessor.roles.exists?(name: "contentcreator")).to eq(true)
        expect(page).to have_current_path("/role_users/new")

        click_on "Back"

        expect(page).to have_current_path("/contentcreator_dashboard")
    end
    
end