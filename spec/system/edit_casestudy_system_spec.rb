require "rails_helper"

RSpec.describe "Edit Casestudy system" do

    before do
        driven_by(:rack_test)
        create(:complete_casestudy)
        @user = User.first
    end

    it "edits a casestudy" do
        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Show All Casestudies"
        expect(page).to have_current_path("/casestudies")
        click_on "Show"
        expect(page).to have_current_path("/casestudies/1")
        expect(page).to have_content("casestudy01")
        click_on "Edit"
        fill_in "casestudy[name]", with: "Case-Study-01"
        fill_in "casestudy[duration]", with: 60
        fill_in "casestudy[scale]", with: 6
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        @casestudy = Casestudy.first
        expect(@casestudy.name).to eq("Case-Study-01")
        expect(@casestudy.duration).to eq(60)
        expect(@casestudy.scale).to eq(6)
    end

    it "edits a page" do
        sign_in @user
        
        visit "/casestudies/1/pages"

        click_on "Show", match: :first
        expect(page).to have_current_path("/casestudies/1/pages/1")
        expect(page).to have_content("This is body of a page in casestudy.")
        click_on "Edit"
        expect(page).to have_current_path("/casestudies/1/pages/1/edit")
        fill_in "page[body]", with: "Some content for first page (edited)."
        click_on "Save"
        expect(page).to have_current_path("/casestudies/1/pages")
        @page1 = Page.first
        expect(@page1.body).to eq("Some content for first page (edited).")
        click_on "Next"
        expect(page).to have_current_path("/casestudies/1/questions")
    end

    it "edits a question" do
        sign_in @user
        
        visit "/casestudies/1/questions"

        click_on "Show", match: :first
        expect(page).to have_current_path("/casestudies/1/questions/1")
        expect(page).to have_content("This is body of a First question in casestudy.")
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
 