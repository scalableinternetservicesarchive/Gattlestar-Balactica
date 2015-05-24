class ExampleMailer < ApplicationMailer
	default from: "from@example.com"

  def sample_email
    @email = 'colinfong@ucla.edu'
    mail(to: @email, subject: 'Sample Email')
  end
end
