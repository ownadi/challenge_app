require_relative 'spec_helper.rb'
require_relative '../app/mailers/question_mailer.rb'

describe AnswerMailer do
  context '#accepted' do
    let(:user) { double(email: 'test@testland.pl') }
    subject { AnswerMailer.accepted(user, double(id: 1)) }

    its(:from) { should include('notifier@qa.pl') }
    its(:to) { should include(user.email) }
    its(:subject) { should == 'Your answer has been accepted!' }
    #it { (subject.body.raw_source).should include(link_to 'Click me!', question_url(double(id: 1))) } #there are problems with testing absolute urls :(
  end
end
