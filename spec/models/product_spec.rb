require 'rails_helper'

RSpec.describe Product, type: :model do

  let (:category) {
    Category.create(name: 'test_category')
  }

  subject {
    category.products.create(name:'Josh', price_cents: 500, quantity: 500)
  }
  describe 'Validations' do
    it 'is created successfully' do
      expect(subject).to be_valid 
      expect(subject.errors.full_messages).to be_empty
    end
    it 'should have a name' do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include "Name can't be blank"
    end
    it 'should have a price_cents' do
      subject.price_cents = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include "Price can't be blank"
    end
    it 'should have a quantity' do 
      subject.quantity = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'should not be valid without category' do
      test_product = Product.create(name:'Josh', price_cents: 500, quantity: 500)
      expect(test_product).to be_invalid
      expect(test_product.errors.full_messages).to include "Category can't be blank"
    end   
  end
end