require 'rails_helper'

RSpec.describe Person, type: :model do
  it "creates a person with valid attributes" do
    person = Person.new(name: "John Doe", address: "123 Main St, 90210")
    expect(person).to be_valid
    expect(person.save).to be true
  end

  it "does not create a person without a name" do
    person = Person.new(address: "123 Main St, 90210")
    expect(person).to_not be_valid
    expect(person.errors[:name]).to include("can't be blank")
    expect(person.save).to be false
  end

  it "does not create a person without an address" do
    person = Person.new(name: "John Doe")
    expect(person).to_not be_valid
    expect(person.errors[:address]).to include("can't be blank")
    expect(person.save).to be false
  end

  it "does not create a person with a duplicate name" do
    Person.create!(name: "John Doe", address: "123 Main St, 90210")
    person = Person.new(name: "John Doe", address: "456 Another St, 90210")
    expect(person).to_not be_valid
    expect(person.errors[:name]).to include("has already been taken")
    expect(person.save).to be false
  end

  it "does not create a person with a name longer than 40 characters" do
    long_name = "a" * 41
    person = Person.new(name: long_name, address: "123 Main St, 90210")
    expect(person).to_not be_valid
    expect(person.errors[:name]).to include("is too long (maximum is 40 characters)")
    expect(person.save).to be false
  end

  it "does not create a person with an address longer than 200 characters" do
    long_address = "a" * 201
    person = Person.new(name: "John Doe", address: long_address)
    expect(person).to_not be_valid
    expect(person.errors[:address]).to include("is too long (maximum is 200 characters)")
    expect(person.save).to be false
  end
end
