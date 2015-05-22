class MesageMailer < ApplicationMailer
	# use your own email address here
  default :to => "colinfong@ucla.edu"

  def message_me(msg)
  	@msg = msg

    mail from: @msg.email, subject: @msg.subject, body: @msg.content
  end
end
