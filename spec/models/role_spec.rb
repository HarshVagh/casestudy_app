require "rails_helper"

RSpec.describe Role, type: :model do

    subject { build(:candidate_role) }
    
    describe "associations" do
        it { should have_many(:role_users) } 
        it { should have_many(:users).through(:role_users) } 
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without a name"do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is not valid if length of name is out of range (3,30)" do
        subject.name = "ab"
        expect(subject).to_not be_valid
    end

    it "is not valid if name include symbols or numbers" do
        subject.name = "abc@123"
        expect(subject).to_not be_valid
    end
    
    it "should have unique name" do
        create(:candidate_role)
        expect(subject).to_not be_valid
    end
end