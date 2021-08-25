require "rails_helper"

RSpec.describe Question, type: :model do
    
    describe "associations" do
        it { should belong_to(:casestudy) } 
        it { should have_many(:user_responses) } 
        it { should have_many(:question_traits) } 
        it { should have_many(:traits).through(:question_traits) } 
    end

    subject { described_class.new(
        body: "What is question for this casestudy?",
        casestudy_id: 1
    )}

    before do
        Role.create(name: "candidate")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "testcreator", email: "testuser1@mail.com", password: "pass1234")
        @user.roles << @role
        @casestudy = Casestudy.create(name: "casestudy01", contentcreator_id: @user.id)
    end

    after do
        RoleUser.delete_all
        CasestudyUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
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