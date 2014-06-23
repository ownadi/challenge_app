class AnswerMailer < ActionMailer::Base
  default from: "notifier@qa.pl"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.answer_mailer.accepted.subject
  #
  def accepted(target, question)
    @question = question

    mail to: target.email, subject: "Your answer has been accepted!"
  end
end
