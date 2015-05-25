class SpamMailer < ApplicationMailer
	default from: "uclatestbank188@gmail.com"

	def spam_email(description, document, reporter)
    @desc = description
    @doc = document
    @reporter = reporter
    mail(to: "uclatestbank188@gmail.com", subject: "Document #{@desc} Reported As Spam")
  end
end
