class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.error_occured.subject
  #
  def error_occured(error)
    @error = error

    mail to: "jamesreading473@gmail.com", subject: 'Error occured in depot app'
  end
end
