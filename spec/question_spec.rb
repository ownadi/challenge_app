require_relative 'spec_helper.rb'
require_relative '../app/models/question.rb'
require 'shoulda-matchers'

describe Question do
  it { should validate_presence_of(:title) }
end
