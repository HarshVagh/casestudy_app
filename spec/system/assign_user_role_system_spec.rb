require "rails_helper"

RSpec.describe "Assign User Role System" do
    
    before do
        driven_by(:rack_test)
        Role.create(name: "candidate")
        Role.create(name: "assessor")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "test", email: "test01@g.c", password: "11111111")
        @user.roles << @role
        User.create(name: "test two", email: "test02@g.c", password: "11111111")
        User.create(name: "test three", email: "test03@g.c", password: "11111111")
        
    end

    after do
        RoleUser.delete_all
        @user.destroy
        @role.destroy
        User.delete_all
        Role.delete_all
    end

    it "assigns role to users" do
        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Assign Roles"
        expect(page).to have_current_path("/role_users/new")

        find(:select, name: "role_user[user_id]").find(:option, "test two").select_option
        find(:select, name: "role_user[role_id]").find(:option, "assessor").select_option
        click_on "Assign"

        role_user = RoleUser.where(user_id: 2).last
        expect(role_user.role_id).to eq(2)

        expect(page).to have_current_path("/role_users/new")

        find(:select, name: "role_user[user_id]").find(:option, "test three").select_option
        find(:select, name: "role_user[role_id]").find(:option, "contentcreator").select_option
        click_on "Assign"

        role_user = RoleUser.where(user_id: 3).last
        expect(role_user.role_id).to eq(3)

        expect(page).to have_current_path("/role_users/new")

        click_on "Back"

        expect(page).to have_current_path("/contentcreator_dashboard")


    end
    
end