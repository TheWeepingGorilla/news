require 'rails_helper'

describe Link do
  it { should have_many(:comments) }
end
