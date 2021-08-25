require "rails_helper"

RSpec.describe Trait, type: :model do
    
    describe "associations" do
        it { should have_many(:question_trait) } 
        it { should have_many(:questions).through(:question_trait) } 
    end

    subject { described_class.new(name: "Trait01")}

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without a name"do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is not valid if length of name greater than 30" do
        subject.name = "TraitTraitTraitTraitTraitTraitTrait"
        expect(subject).to_not be_valid
    end

    it "is not valid trait name already exists" do
        Trait.create(name: "Trait01")
        expect(subject).to_not be_valid
    end
    
end