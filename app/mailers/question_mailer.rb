class QuestionMailer < ActionMailer::Base
  default from: "notifier@qa.pl"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.new_answer.subject
  #
  def new_answer(target, question)
    @question = question
    mail to: target.email, subject: 'Someone answered your question!'
  end
end
