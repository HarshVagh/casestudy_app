require "rails_helper"

RSpec.describe User, type: :model do

    subject { build(:candidate) }

    describe "associations" do
        it { should have_many(:role_users) }
        it { should have_many(:roles).through(:role_users) }
        it { should have_many(:user_responses) }
        it { should have_many(:casestudy_users) }
        it { should have_many(:casestudies).through(:casestudy_users) }
        it { should have_many(:assessor_responses) }
        it { should have_many(:created_casestudies).class_name("Casestudy").with_foreign_key("contentcreator_id") }
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end
    
    it "is not valid without a name" do
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
    
    it "is not valid without a email" do
        subject.email = nil
        expect(subject).to_not be_valid
    end
    
    it "is not valid if email alrady exists" do
        create(:candidate)
        expect(subject).to_not be_valid
    end
    
    it "is not valid if length of eamil is greater then 50" do
        subject.email = "testuser1testuser1testuser1testuser1testuser1@mail.com"
        expect(subject).to_not be_valid
    end
    
    it "is not valid with incorrect email format" do
        subject.email = "testusermail.com"
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a password" do
        subject.password = nil
        expect(subject).to_not be_valid
    end

    it "should have candidate role after create" do
        create(:candidate_role)
        subject.save
        expect(subject.roles.exists?(name: "candidate")).to eq(true)
    end
end