require "rails_helper"

RSpec.describe UserResponse, type: :model do
    
    describe "associations" do
        it { should belong_to(:question) } 
        it { should belong_to(:casestudy_user) }
        it { should belong_to(:user) }
    end

    subject { described_class.new(
        response: "This is a response.",
        question_id: 1,
        casestudy_user_id: 1,
        user_id: 1
    )}

    before do
        Role.create(name: "candidate")
        @assessor_role = Role.create(name: "assessor")
        @creator_role = Role.create(name: "contentcreator")
        @user1 = User.create(name: "testcreator", email: "testuser1@mail.com", password: "pass1234")
        @user2 = User.create(name: "testassessor", email: "testuser2@mail.com", password: "pass1234")
        @user3 = User.create(name: "testcandidate", email: "testuser3@mail.com", password: "pass1234")
        @user1.roles << @creator_role
        @user2.roles << @assessor_role
        @casestudy = Casestudy.create(name: "casestudy01", contentcreator_id: @user1.id)
        Question.create(body: "What is question for this casestudy?", casestudy_id: @casestudy.id)
        @casestudy_user = CasestudyUser.create(status: "pending", time_elaspsed: 0, casestudy_id: @casestudy.id, user_id: @user3.id, assessor_id: @user2.id)
    end

    after do
        RoleUser.delete_all
        UserResponse.delete_all
        Question.delete_all
        CasestudyUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
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
        UserResponse.create(response: "This is a test response.", question_id: 1, casestudy_user_id: 1, user_id: 1)
        expect(subject).to_not be_valid
    end
    
end