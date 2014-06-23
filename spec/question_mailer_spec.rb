require_relative 'spec_helper.rb'
require_relative '../app/mailers/question_mailer.rb'

describe QuestionMailer do
  context '#new_answer' do
    let(:user) { double(email: 'test@testland.pl') }
    subject { QuestionMailer.new_answer(user, double(id: 1)) }

    its(:from) { should include('notifier@qa.pl') }
    its(:to) { should include(user.email) }
    its(:subject) { should == 'Someone answered your question!' }
    #it { (subject.body.raw_source).should include(link_to 'Click me!', question_url(double(id: 1))) } #there are problems with testing absolute urls :(
  end
end
