require "rails_helper"

RSpec.describe "Add Trait System" do
    
    before do
        driven_by(:rack_test)
        @user = create(:contentcreator)
    end

    it "add new trait" do
        sign_in @user
        
        visit "/contentcreator_dashboard"
        click_on "Add Trait"
        expect(page).to have_current_path("/traits/new")

        fill_in "trait[name]",	with: "Trait01"
        click_on "Add Trait" 
        expect(page).to have_current_path("/traits/new")

        trait = Trait.first
        expect(trait.name).to eq("Trait01")
        
        fill_in "trait[name]",	with: "Trait02"
        click_on "Add Trait" 
        expect(page).to have_current_path("/traits/new")

        trait = Trait.last
        expect(trait.name).to eq("Trait02")

        click_on "Back"
        expect(page).to have_current_path("/contentcreator_dashboard")
    end
    
end