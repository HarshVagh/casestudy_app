require "rails_helper"

RSpec.describe RoleUser, type: :model do
    
    subject { described_class.new(user_id: 1, role_id:1)}

    describe "associations" do
        it { should belong_to(:user) } 
        it { should belong_to(:role) } 
    end

    it "is not valid without a user id"do
        subject.user_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without a role id" do
        subject.role_id = nil
        expect(subject).to_not be_valid
    end

    it "is should be unique" do
        create(:candidate_role)
        create(:user)
        expect(subject).to_not be_valid
    end
    
end