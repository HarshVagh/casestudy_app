require "rails_helper"

RSpec.describe QuestionTrait, type: :model do
    
    describe "associations" do
        it { should belong_to(:trait) } 
        it { should belong_to(:question) } 
        it { should have_many(:assessor_responses) } 
    end

    subject { described_class.new(question_id: 1, trait_id:1)}

    before do
        Role.create(name: "candidate")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "testcreator", email: "testuser1@mail.com", password: "pass1234")
        @user.roles << @role
        Trait.create(name: "Trait01")
        @casestudy = Casestudy.create(name: "casestudy01", contentcreator_id: @user.id)
        @question = Question.create(body: "What is question for this casestudy?", casestudy_id: @casestudy.id)
    end

    after do
        RoleUser.delete_all
        QuestionTrait.delete_all
        Question.delete_all
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

    it "is not valid without a trait id" do
        subject.trait_id = nil
        expect(subject).to_not be_valid
    end

    it "is should be unique" do
        QuestionTrait.create(question_id: 1, trait_id:1)
        expect(subject).to_not be_valid
    end
    
end