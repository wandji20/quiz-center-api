require 'rails_helper'

RSpec.describe AnsweredQuestion, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should belong_to(:quiz) }
end
