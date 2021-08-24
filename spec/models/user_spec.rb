require "rails_helper"

RSpec.describe User, type: :model do

    subject { described_class.new(
        name: "testuser",
        email: "testuser@mail.com",
        password: "pass1234"
    ) }

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
    end
    
    it "is not valid if name include symbols or numbers" do
        subject.name = "abc@123"
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a email" do
        subject.email = nil
        expect(subject).to_not be_valid
    end
    
    it "is not valid if email alrady exists" do
        Role.create(name: "candidate")
        User.create(name: "testuser", email: "testuser@mail.com", password: "pass1234")
        expect(subject).to_not be_valid
    end
    
    it "is not valid if length of eamil is greater then 50" do
        subject.email = "testuser1testuser1testuser1testuser1testuser1@mail.com"
        expect(subject).to_not be_valid
    end
    
    it "is not valid with incorrect email format" do
        subject.email = "testusermail.com"
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a password" do
        subject.password = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without candidate role" do
        #expect(subject).to_not be_valid
    end
end