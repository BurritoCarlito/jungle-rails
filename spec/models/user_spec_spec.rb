require 'rails_helper'

RSpec.describe UserSpec, type: :model do
  describe 'Validations' do

    it "should create valid user" do
      user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user).to be_valid
    end

    it 'should fail to save user without first name' do 
      user = User.create(
        last_name: "Tanjuauqio",
        first_name: nil,
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
        )
        expect(user.errors.full_messages).to include "First name can't be blank"
    end

    it "should fail to save user without a last name" do 
      user = User.create(
        first_name: "Carlo",
        last_name: nil,
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it "should fail to save user without a email" do 
      user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: nil,
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "should fail to save user without matching password confirmations" do 
      user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "54321"
      )
      expect(user).to_not be_valid
    end

    it "should fail to save user with the same email" do 
      user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "54321"
        )
      user2 = User.create(
        first_name: "Derrick",
        last_name: "Rose",
        email: "EXAMPLE@GMAIL.COM",
        password: "12345",
        password_confirmation: "12345"
      )
      expect(user).to_not be_valid
    end

    it "should fail to save user if password is less than three characters" do
      user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12",
        password_confirmation: "12"
      )
      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end


describe ".authenticate_with_credentials?" do 
  it "should login valid user" do 
    user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
    )
    userA = User.authenticate_with_credentials(user.email, user.password)
    expect(userA.id).to be user.id
  end
  
  it "should login the user if there are spaces in the email" do
    user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
    )
    userA = User.authenticate_with_credentials(" example@gmail.com", user.password)
    expect(userA.id).to be user.id
  end

  it "should login the user with a case sensitive email" do 
    user = User.create(
        first_name: "Carlo",
        last_name: "Tanjuauqio",
        email: "example@gmail.com",
        password: "12345",
        password_confirmation: "12345"
    )
    userA = User.authenticate_with_credentials("EXAMPLE@GMAIL.COM", user.password)
    expect(userA.id).to be user.id
    end
  end
end