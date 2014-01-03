require 'spec_helper'

describe User do
  it 'is valid with a first name, last name, and user name' do
    user = create(:user)
    expect(user).to be_valid
  end

  it 'is invalid without a first name' do
    pending("User model needs validations")
    expect(User.new(first_name: nil)).to have(1).errors_on(:first_name)
  end

  it 'is invalid without a last name' do
    pending("User model needs validations")
    expect(User.new(last_name: nil)).to have(1).errors_on(:last_name)
  end

  it 'is invalid without a user name' do
    pending("User model needs validations")
    expect(User.new(user_name: nil)).to have(1).errors_on(:user_name)
  end

  it 'is invalid with a duplicate user name' do
    user = create(:user)
    other_user = User.new(first_name: 'Werner', last_name: 'Heisenberg', user_name: 'heisenberg')
    expect(other_user).to have(1).errors_on(:user_name)
  end
end
