require 'rails_helper'

describe Comment do
  it { should have_many(:comments) }
end
