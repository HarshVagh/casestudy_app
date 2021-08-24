require "rails_helper"

RSpec.describe "Give Assessment System" do
    before do
        driven_by(:rack_test)
        Role.create(name: "candidate")
        @role1 = Role.create(name: "assessor")
        @role2 = Role.create(name: "contentcreator")
        @contentcreator = User.create(name: "test", email: "test1@g.c", password: "11111111")
        @assessor = User.create(name: "test two", email: "test02@g.c", password: "11111111")
        @candidate = User.create(name: "test three", email: "test03@g.c", password: "11111111")
        @contentcreator.roles << @role2
        @assessor.roles << @role1
        Trait.create(name: "Trait01")

        @casestudy = Casestudy.create(name: "Casestudy01", duration: 30, scale: 10, contentcreator_id: @contentcreator.id)
        @page1 = Page.create(body: "Some content for first page.", casestudy_id: @casestudy.id)
        @question1 = Question.create(body: "What is Question 01?", casestudy_id: @casestudy.id)
        QuestionTrait.create(question_id: @question1.id, trait_id: 1)
        @casestudy_user = CasestudyUser.create(user_id: @candidate.id, assessor_id: @assessor.id, casestudy_id: @casestudy.id, status: "pending", time_elaspsed: 0)
    end

    after do
        RoleUser.delete_all
        Page.delete_all
        QuestionTrait.delete_all
        UserResponse.delete_all
        CasestudyUser.delete_all
        Question.delete_all
        Trait.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
    end

    it "gives an assessment" do
        
        sign_in @candidate
        visit "/candidate_dashboard"

        click_on "Show Assessments"

        expect(page).to have_current_path("/casestudy_users")
        
        click_on "Start"

        expect(page).to have_current_path("/casestudy_users/1/user_responses")

        click_on "Start Assessment"

        expect(page).to have_current_path("/casestudy_users/1/user_responses/new")

        fill_in "user_response[response]", with: "This is answer for question 01."
        click_on "Save"
        expect(page).to have_current_path("/casestudy_users/1/user_responses/new")
        @user_response1 = UserResponse.first
        expect(@user_response1.casestudy_user_id).to eq(1)
        expect(@user_response1.question_id).to eq(1)
        expect(@user_response1.user_id).to eq(@candidate.id)
        expect(@user_response1.response).to eq("This is answer for question 01.")
        
        click_on "Finish Assessment"

        expect(page).to have_current_path("/candidate_dashboard")
        
    end
    
    
end
