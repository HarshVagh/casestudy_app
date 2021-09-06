require "rails_helper"

RSpec.describe CasestudyUser, type: :model do
    before do
        create(:complete_casestudy)
        create(:assessor)
        create(:candidate)
    end

    let(:assessment) { build(:casestudy_user) }

    describe "associations" do
        it { should belong_to(:user) }
        it { should belong_to(:casestudy) }
        it { should belong_to(:assessor).class_name("User") }
        it { should have_many(:user_responses) }
        it { should have_many(:assessor_responses) }
    end

    it "is valid with valid attributes" do
        expect(assessment).to be_valid
    end

    it "is not valid without a casestudy id" do
        assessment.casestudy_id = nil
        expect(assessment).to_not be_valid
    end

    it "is not valid without a user id" do
        assessment.user_id = 0
        expect(assessment).to_not be_valid
    end

    it "is not valid without a assessor id" do
        assessment.assessor_id = nil
        expect(assessment).to_not be_valid
    end

    it "is not valid without status" do
        assessment.status = nil
        expect(assessment).to_not be_valid
    end

    it "is not valid without time_elaspsed" do
        assessment.time_elaspsed = nil
        expect(assessment).to_not be_valid
    end

    it "is not valid if assessor_id is equal to user_id" do
        assessment.assessor_id = 3
        expect(assessment).to_not be_valid
    end

    it "should only accept status in pending, ongoing, completed" do
        assessment.status = "pending"
        expect(assessment).to be_valid
        assessment.status = "ongoing"
        expect(assessment).to be_valid
        assessment.status = "completed"
        expect(assessment).to be_valid
        assessment.status = "finished"
        expect(assessment).to_not be_valid
    end

    it "should have be unique for (casestudy,user)" do
        create(:casestudy_user)
        expect(assessment).to_not be_valid
    end
end