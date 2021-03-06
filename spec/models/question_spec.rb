require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:description) }
  it { should belong_to(:quiz) }
  it { should accept_nested_attributes_for(:answers) }
end
