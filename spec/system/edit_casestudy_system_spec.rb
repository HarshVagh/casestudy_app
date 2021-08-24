require "rails_helper"

RSpec.describe "Edit Casestudy system" do

    before do
        driven_by(:rack_test)
        Role.create(name: "candidate")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "test", email: "test1@g.c", password: "11111111")
        @user.roles << @role
        Trait.create(name: "Trait01")
        Trait.create(name: "Trait02")
        @casestudy = Casestudy.create(name: "Casestudy01", duration: 30, scale: 10, contentcreator_id: @user.id)
        @page1 = Page.create(body: "Some content for first page.", casestudy_id: @casestudy.id)
        @page2 = Page.create(body: "More content for this new page.", casestudy_id: @casestudy.id)
        @question1 = Question.create(body: "What is Question 01?", casestudy_id: @casestudy.id)
        @question2 = Question.create(body: "What is Question 02?", casestudy_id: @casestudy.id)
        QuestionTrait.create(question_id: @question1.id, trait_id: 1)
        QuestionTrait.create(question_id: @question1.id, trait_id: 2)
        QuestionTrait.create(question_id: @question2.id, trait_id: 1)
        QuestionTrait.create(question_id: @question2.id, trait_id: 2)
    end

    after do
        RoleUser.delete_all
        Page.delete_all
        QuestionTrait.delete_all
        Question.delete_all
        Trait.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
    end
    
    it "edits a casestudy" do
        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Show All Casestudies"
        expect(page).to have_current_path("/casestudies")
        click_on "Show"
        expect(page).to have_current_path("/casestudies/1")
        expect(page).to have_content("Casestudy01")
        click_on "Edit"
        fill_in "casestudy[name]", with: "Case-Study-01"
        fill_in "casestudy[duration]", with: 60
        fill_in "casestudy[scale]", with: 6
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        @casestudy = Casestudy.order("id").last
        expect(@casestudy.name).to eq("Case-Study-01")
        expect(@casestudy.duration).to eq(60)
        expect(@casestudy.scale).to eq(6)

        ####################################################################################

        click_on "Show", match: :first
        expect(page).to have_current_path("/casestudies/1/pages/1")
        expect(page).to have_content("Some content for first page.")
        click_on "Edit"
        expect(page).to have_current_path("/casestudies/1/pages/1/edit")
        fill_in "page[body]", with: "Some content for first page (edited)."
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        @page1 = Page.order("id").first
        expect(@page1.body).to eq("Some content for first page (edited).")

        ####################################################################################

        click_on "Next"
        expect(page).to have_current_path("/casestudies/1/questions")
        click_on "Show", match: :first
        expect(page).to have_current_path("/casestudies/1/questions/1")
        expect(page).to have_content("What is Question 01?")
        click_on "Edit"
        expect(page).to have_current_path("/casestudies/1/questions/1/edit")
        fill_in "question[body]", with: "What is Question 01? (edited)"
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/questions/1/question_traits/new")
        @question1 = Question.order("id").first
        expect(@question1.body).to eq("What is Question 01? (edited)")
        click_on "Finish"
        expect(page).to have_current_path("/casestudies/1/questions")
        click_on "Finish"
        expect(page).to have_current_path("/contentcreator_dashboard")

    end

    
end
 