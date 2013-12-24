require 'spec_helper'

describe User do
  it "has no users in the database" do
    expect(User).to have(:no).records
    expect(User).to have(0).records
  end

  it "has one record" do
    User.create!(first_name: 'Walter', last_name: 'White', user_name: 'heisenberg', password: 'foo', password_confirmation: 'foo')
    expect(User.where(:user_name => 'heisenberg')).to have(1).record
  end

  it "counts only records that match a query" do
    User.create!(first_name: 'Walter', last_name: 'White', user_name: 'heisenberg', password: 'foo', password_confirmation: 'foo')
    expect(User.where(:user_name => 'heisenberg')).to have(1).record
    expect(User.where(:user_name => 'gfring')).to have(0).records
  end
end
