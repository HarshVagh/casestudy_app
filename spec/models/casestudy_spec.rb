require "rails_helper"

RSpec.describe Casestudy, type: :model do

    before do
        create(:contentcreator)
    end

    subject { build(:casestudy) }

    describe "associations" do
        it { should have_many(:pages) }
        it { should have_many(:casestudy_users) }
        it { should have_many(:users).through(:casestudy_users) }
        it { should have_many(:questions) }
        it { should belong_to(:contentcreator).class_name("User") }
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
        subject.name = "asdfglkjhzxcvmnbqwertypoiuasdfglkjhzxcvmnbqwertypoiu"
        expect(subject).to_not be_valid
    end
    
    it "should have duration less than 250" do
        subject.duration = 300
        expect(subject).to_not be_valid
    end
    
    it "should have scale in range (6,10)" do
        subject.scale = 3
        expect(subject).to_not be_valid
        subject.scale = 12
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a contentcreator id" do
        subject.contentcreator_id = nil
        expect(subject).to_not be_valid
    end
end