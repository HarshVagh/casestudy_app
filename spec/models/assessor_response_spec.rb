require "rails_helper"

RSpec.describe AssessorResponse, type: :model do
    
    describe "associations" do
        it { should belong_to(:question_trait) } 
        it { should belong_to(:casestudy_user) }
        it { should belong_to(:user) }
        it { should belong_to(:assessor).class_name("User") }
    end

    before do
        Role.create(name: "candidate")
        @assessor_role = Role.create(name: "assessor")
        @creator_role = Role.create(name: "contentcreator")
        @user1 = User.create(name: "testcreator", email: "testuser1@mail.com", password: "pass1234")
        @user2 = User.create(name: "testassessor", email: "testuser2@mail.com", password: "pass1234")
        @user3 = User.create(name: "testcandidate", email: "testuser3@mail.com", password: "pass1234")
        @user1.roles << @creator_role
        @user2.roles << @assessor_role
        Trait.create(name: "Trait01")
        @casestudy = Casestudy.create(name: "casestudy01", contentcreator_id: @user1.id)
        Question.create(body: "What is question for this casestudy?", casestudy_id: @casestudy.id)
        QuestionTrait.create(question_id: 1, trait_id:1)
        @casestudy_user = CasestudyUser.create(status: "pending", time_elaspsed: 0, casestudy_id: @casestudy.id, user_id: @user3.id, assessor_id: @user2.id)
        @assessor_response = AssessorResponse.new(
            rating: 4.2,
            question_trait_id: 1,
            casestudy_user_id: 1,
            user_id: 3,
            assessor_id: 2
        )
    end

    after do
        RoleUser.delete_all
        UserResponse.delete_all
        QuestionTrait.delete_all
        Trait.delete_all
        Question.delete_all
        CasestudyUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
    end
    

    it "is valid with valid attributes" do
        expect(@assessor_response).to be_valid
    end

    it "is not valid without a question_trait id"do
        @assessor_response.question_trait_id = nil
        expect(@assessor_response).to_not be_valid
    end

    it "is not valid without a casestudy_user id"do
        @assessor_response.casestudy_user_id = nil
        expect(@assessor_response).to_not be_valid
    end

    it "is not valid without a user id"do
        @assessor_response.user_id = nil
        #expect(@assessor_response).to_not be_valid
    end

    it "is not valid without a assessor id"do
        @assessor_response.assessor_id = nil
        expect(@assessor_response).to_not be_valid
    end

    it "is not valid without a rating"do
        @assessor_response.rating = nil
        expect(@assessor_response).to_not be_valid
    end

    it "is not valid if assessor_id is equal to user_id" do
        @assessor_response.assessor_id = 3
        expect(@assessor_response).to_not be_valid
    end
    
end