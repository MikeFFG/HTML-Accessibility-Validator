require 'mail'
require 'net/smtp'

class Email
  attr_accessor :options

  def initialize(file)
    @file = file
    @options = { :address => "smtp.gmail.com",
                 :port => 587,
                 :user_name => 'pixoqainternal@gmail.com',
                 :password => 'iZotope1986',
                 :authentication => 'plain',
                 :enable_starttls_auto => true }
  end

  def send
    self.configureMail
    self.attachFile(@file)
    @mail.deliver
  end

  def attachFile(file)
    @mail.add_file(file)
  end

  def configureMail
    @mail = Mail.new do
      from 'qa@pixotech.com'
      to 'mike@pixotech.com'
      subject 'test'
      body 'test'
    end
  end
end
