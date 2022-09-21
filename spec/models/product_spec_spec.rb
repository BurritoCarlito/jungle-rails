require 'rails_helper'

RSpec.describe ProductSpec, type: :model do
  describe "Validations" do 
    # validation tests/examples here
    it 'saves product to database' do
      category = Category.create(name: "Cactus")
      product = Product.create(name: "spikey", price: 500, quantity: 5, category: category)
      expect(product).to be_present
    end

    it "does not save if name is missing" do
      category = Category.create(name: "Cactus")
      product = Product.create(name: nil , price: 500, quantity: 5, category: category)
      expect(product.errors.full_messages).to include "Name can't be blank"
    end

    it "does not save if price is missing" do
      category = Category.create(name: "Cactus")
      product = Product.create(name: "spikey" , price: false, quantity: 5, category: category)
      expect(product.errors.full_messages).to include "Price can't be blank"
    end

    it "does not save if quantity is missing" do 
      category = Category.create(name: "Cactus")
      product = Product.create(name: "spikey" , price: 500, quantity: nil, category: category)
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "does not save if category is missing" do 
      category = Category.create(name: "Cactus")
      product = Product.create(name: "spikey", price: 500, quantity: 5, category: nil)
      expect(product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
