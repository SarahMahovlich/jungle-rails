require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    described_class.new(name: "Bobby Bob", email: 'bobby@gmail.com', password: 'password', password_confirmation: 'password')
  }
  
  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
      expect(subject.errors).to be_empty
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to_not be_empty
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to_not be_empty
    end

    it "is not valid when email is already in database" do
      testuser = described_class.create!(name: "Test user", email: 'boBBy@gmail.com', password: 'password', password_confirmation: 'password')
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to_not be_empty
    end

    it "is not valid without when password and confirmation don't match" do
      subject.password = "password"
      subject.password_confirmation = "passwords"
      expect(subject).to_not be_valid
      expect(subject.errors[:password_confirmation]).to_not be_empty
    end

    it "is not valid without a password of length 6" do
      subject.password = "pass"
      subject.password_confirmation = "pass"
      expect(subject).to_not be_valid
      expect(subject.errors[:password]).to_not be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it "is valid when email and password are in the database" do
      user = User.authenticate_with_credentials('bobby@gmail.com', 'password')
      expect(subject).eql? user
    end

    it "is nil if when password wrong" do
      user = User.authenticate_with_credentials('bobby@gmail.com', 'passwordsdfs')
      expect(subject).eql? nil
    end

    it "login is valid if email entered with whitespace" do
      user = User.authenticate_with_credentials('  bobby@gmail.com  ', 'password')
      expect(subject).to be_valid
    end

    it "login is valid if email entered with capitals" do
      user = User.authenticate_with_credentials('boBBy@gmail.com', 'password')
      expect(subject).to be_valid
    end
  end

end


