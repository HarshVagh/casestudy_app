require "rails_helper"

RSpec.describe Question, type: :model do

    before do
        create(:casestudy_creator)
    end

    subject { build(:question) }
    
    describe "associations" do
        it { should belong_to(:casestudy) } 
        it { should have_many(:user_responses) } 
        it { should have_many(:question_traits) } 
        it { should have_many(:traits).through(:question_traits) } 
    end


    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without body"do
        subject.body = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without casestudy id"do
        subject.casestudy_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid if length of body is out of range (10,1000)" do
        subject.body = "question"
        expect(subject).to_not be_valid
    end
    
end