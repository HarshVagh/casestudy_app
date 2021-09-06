require "rails_helper"

RSpec.describe Page, type: :model do

    before do
        create(:contentcreator)
        create(:casestudy)
    end

    subject { create(:page) }
    
    describe "associations" do
        it { should belong_to(:casestudy) }
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end
    
    it "is not valid without body"do
        subject.body = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a casestudy id" do
        subject.casestudy_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid if length of body is out of range (3,3000)" do
        subject.body = "page one"
        expect(subject).to_not be_valid
    end
    
end