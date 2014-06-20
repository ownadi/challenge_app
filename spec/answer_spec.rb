require_relative 'spec_helper.rb'
require_relative '../app/models/answer.rb'
require 'shoulda-matchers'

describe Answer do
  it { should validate_presence_of(:contents) }
end
