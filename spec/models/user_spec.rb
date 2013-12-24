require 'spec_helper'

describe User do
  it "has no records in the database" do
    expect(User).to have(:no).records
    expect(User).to have(0).records
  end

  it "has one record" do
    user = create(:user)
    expect(User.where(:user_name => 'heisenberg')).to have(1).record
  end

  it "counts only records that match a query" do
    user = create(:user)
    expect(User.where(:user_name => 'heisenberg')).to have(1).record
    expect(User.where(:user_name => 'gfring')).to have(0).records
  end
end
