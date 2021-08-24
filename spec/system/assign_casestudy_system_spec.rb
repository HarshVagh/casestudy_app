require "rails_helper"

RSpec.describe "Assign Casestudy System" do
    
    before do
        driven_by(:rack_test)
        Role.create(name: "candidate")
        @role1 = Role.create(name: "assessor")
        @role2 = Role.create(name: "contentcreator")
        @user1 = User.create(name: "test", email: "test1@g.c", password: "11111111")
        @user2 = User.create(name: "test two", email: "test02@g.c", password: "11111111")
        User.create(name: "test three", email: "test03@g.c", password: "11111111")
        @user1.roles << @role2
        @user2.roles << @role1
        @casestudy = Casestudy.create(name: "Casestudy01", duration: 30, scale: 10, contentcreator_id: @user1.id)
    end

    after do
        RoleUser.delete_all
        CasestudyUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
    end

    it "assigns casestudy to users" do
        sign_in @user1
        visit "/contentcreator_dashboard"
        click_on "Assign Casestudy"
        expect(page).to have_current_path("/casestudy_users/new")

        find(:select, name: "casestudy_user[user_id]").find(:option, "test three").select_option
        find(:select, name: "casestudy_user[assessor_id]").find(:option, "test two").select_option
        find(:select, name: "casestudy_user[casestudy_id]").find(:option, "Casestudy01").select_option
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