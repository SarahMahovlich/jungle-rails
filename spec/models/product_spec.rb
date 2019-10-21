require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.new(:name => "Junk") }

  subject {
    described_class.new(name: "Chair", price: 50, quantity: 50, category: category)
  }

  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:name]).to_not be_empty
    end

    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:price_cents]).to_not be_empty
    end
    
    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:quantity]).to_not be_empty
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:category]).to_not be_empty
    end
  end
end
