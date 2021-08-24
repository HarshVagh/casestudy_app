require "rails_helper"

RSpec.describe "Casestudy System", type: :system do
    
    before do
        driven_by(:rack_test)
        Role.create(name: "candidate")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "test", email: "test1@g.c", password: "11111111")
        @user.roles << @role
        Trait.create(name: "Trait01")
        Trait.create(name: "Trait02")
    end

    after do
        RoleUser.delete_all
        Page.delete_all
        QuestionTrait.delete_all
        Question.delete_all
        Trait.delete_all
        Casestudy.delete_all
        @user.destroy
        @role.destroy
        User.delete_all
        Role.delete_all
    end

    it "creates a new casestudy along with pages and questions" do

        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Create Casestudy"
        expect(page).to have_current_path("/casestudies/new")
        
        fill_in "casestudy[name]", with: "Casestudy01"
        fill_in "casestudy[duration]", with: 30
        fill_in "casestudy[scale]", with: 10
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        
        casestudy = Casestudy.order("id").last
        expect(casestudy.name).to eq("Casestudy01")
        expect(casestudy.duration).to eq(30)
        expect(casestudy.scale).to eq(10)

        ####################################################################################

        click_on "Add Page"
        expect(page).to have_current_path("/casestudies/1/pages/new")

        fill_in "page[body]", with: "Some content for first page."
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        page1 = Page.order("id").last
        expect(page1.body).to eq("Some content for first page.")
        expect(page1.casestudy_id).to eq(casestudy.id)

        click_on "Add Page"
        expect(page).to have_current_path("/casestudies/1/pages/new")

        fill_in "page[body]", with: "More content for this new page."
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        page2 = Page.order("id").last
        expect(page2.body).to eq("More content for this new page.")
        expect(page2.casestudy_id).to eq(casestudy.id)

        ####################################################################################

        click_on "Next"
        expect(page).to have_current_path("/casestudies/1/questions")

        click_on "Add Question"
        expect(page).to have_current_path("/casestudies/1/questions/new")

        fill_in "question[body]", with: "What is Question 01?"
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/questions/1/question_traits/new")
        question1 = Question.order("id").last
        expect(question1.body).to eq("What is Question 01?")

        find(:select).find(:option, "Trait01").select_option
        click_on "Add Trait"
        expect(page).to have_current_path("/casestudies/1/questions/1/question_traits/new")
        expect(question1.traits.first.name).to eq("Trait01")

        find(:select).find(:option, "Trait02").select_option
        click_on "Add Trait"
        expect(page).to have_current_path("/casestudies/1/questions/1/question_traits/new")
        expect(question1.traits.last.name).to eq("Trait02")

        click_on "Finish"
        expect(page).to have_current_path("/casestudies/1/questions")
        
        ####################################################################################

        click_on "Add Question"
        expect(page).to have_current_path("/casestudies/1/questions/new")

        fill_in "question[body]", with: "What is Question 02?"
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/questions/2/question_traits/new")
        question1 = Question.order("id").last
        expect(question1.body).to eq("What is Question 02?")

        find(:select).find(:option, "Trait01").select_option
        click_on "Add Trait"
        expect(page).to have_current_path("/casestudies/1/questions/2/question_traits/new")
        expect(question1.traits.first.name).to eq("Trait01")

        find(:select).find(:option, "Trait02").select_option
        click_on "Add Trait"
        expect(page).to have_current_path("/casestudies/1/questions/2/question_traits/new")
        expect(question1.traits.last.name).to eq("Trait02")

        click_on "Finish"
        expect(page).to have_current_path("/casestudies/1/questions")
        click_on "Finish"


        ####################################################################################


        expect(page).to have_current_path("/contentcreator_dashboard")

        click_on "Show All Casestudies"
        expect(page).to have_current_path("/casestudies")
    end
    
end
