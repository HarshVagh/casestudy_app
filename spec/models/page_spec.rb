require "rails_helper"

RSpec.describe Page, type: :model do
    
    describe "associations" do
        it { should belong_to(:casestudy) }
    end

    subject { described_class.new(body: "A page for some casestudy.", casestudy_id:1)}

    before do
        Role.create(name: "candidate")
        @role = Role.create(name: "contentcreator")
        @user = User.create(name: "testuser", email: "testuser@mail.com", password: "pass1234")
        @user.roles << @role
        Casestudy.create(name: "casestudy01", contentcreator_id: @user.id)
    end

    after do
        RoleUser.delete_all
        Casestudy.delete_all
        User.delete_all
        Role.delete_all
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