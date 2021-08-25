require "rails_helper"

RSpec.describe CasestudyUser, type: :model do

    describe "associations" do
        it { should belong_to(:user) }
        it { should belong_to(:casestudy) }
        it { should belong_to(:assessor).class_name("User") }
        it { should have_many(:user_responses) }
        it { should have_many(:assessor_responses) }
    end

    let(:assessment) { described_class.new(status: "pending", time_elaspsed: 0, casestudy_id: 1, user_id: 3, assessor_id: 2)}

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
    end

    after do
        RoleUser.delete_all
        CasestudyUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
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
end