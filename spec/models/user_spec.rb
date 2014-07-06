require 'spec_helper'

describe User, :type => :model do
  it 'is valid with a first name, last name, and user name' do
    user = create(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    user = User.new(first_name: nil, last_name: 'Heisenberg', user_name: 'heisenberg', password: 'foo')
    user.valid?
    expect(user.errors).to have_exactly(1).errors
  end

  it 'is invalid without a last name' do
    user = User.new(first_name: 'Werner', last_name: nil, user_name: 'heisenberg', password: 'foo')
    user.valid?
    expect(user.errors).to have_exactly(1).errors
  end

  it 'is invalid without a user name' do
    user = User.new(first_name: 'Werner', last_name: 'Heisenberg', user_name: nil, password: 'foo')
    user.valid?
    expect(user.errors).to have_exactly(1).errors
  end

  it 'is invalid with a duplicate user name' do
    user = create(:user)
    other_user = User.new(first_name: 'Werner', last_name: 'Heisenberg', user_name: 'heisenberg', password: 'foo')
    other_user.valid?
    expect(other_user.errors).to have_exactly(1).errors
  end
end
