require "rails_helper"

RSpec.describe AssessorResponse, type: :model do
    
    before do
        create(:complete_casestudy_user)
        create(:user_response)
    end

    let(:response) { build(:assessor_response) }

    describe "associations" do
        it { should belong_to(:question_trait) } 
        it { should belong_to(:casestudy_user) }
        it { should belong_to(:user) }
        it { should belong_to(:assessor).class_name("User") }
    end

    it "is valid with valid attributes" do
        expect(response).to be_valid
    end

    it "is not valid without a question_trait id"do
        response.question_trait_id = nil
        expect(response).to_not be_valid
    end

    it "is not valid without a casestudy_user id"do
        response.casestudy_user_id = nil
        expect(response).to_not be_valid
    end

    it "is not valid without a assessor id"do
        response.assessor_id = nil
        expect(response).to_not be_valid
    end

    it "is not valid without a rating"do
        response.rating = nil
        expect(response).to_not be_valid
    end

    it "is not valid if assessor_id is equal to user_id" do
        response.assessor_id = 3
        expect(response).to_not be_valid
    end

    it "should have be unique for (casestudy_user ,question_trait)" do
        create(:assessor_response)
        expect(response).to_not be_valid
    end
    
end