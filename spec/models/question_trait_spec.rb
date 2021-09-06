require "rails_helper"

RSpec.describe QuestionTrait, type: :model do

    before do
        create(:casestudy_creator)
        create(:question)
        create(:trait1)
    end

    subject { described_class.new(question_id: 1, trait_id:1)}
    
    describe "associations" do
        it { should belong_to(:trait) } 
        it { should belong_to(:question) } 
        it { should have_many(:assessor_responses) } 
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