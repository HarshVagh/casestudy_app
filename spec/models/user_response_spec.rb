require "rails_helper"

RSpec.describe UserResponse, type: :model do

    before do
        create(:complete_casestudy_user)
    end

    subject { build(:user_response)}
    
    describe "associations" do
        it { should belong_to(:question) } 
        it { should belong_to(:casestudy_user) }
        it { should belong_to(:user) }
    end
    
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without a question id"do
        subject.question_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a casestudy_user id"do
        subject.casestudy_user_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a user id"do
        subject.user_id = nil
        expect(subject).to_not be_valid
    end

    it "is should be unique" do
        create(:user_response)
        expect(subject).to_not be_valid
    end
    
end