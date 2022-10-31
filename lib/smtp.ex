defmodule SMTPMail  do

  def send do
    :gen_smtp_client.send({"sender@gmail.com", ["sender@gmail.com"],
 "Subject: testing\r\nFrom: Andrew Thompson <andrew@hijacked.us>\r\nTo: Some Dude <foo@bar.com>\r\n\r\nThis is the email body"},
  [{:relay, "smtp.gmail.com"}, {:username, "your@gmail.com"}, {:password, "yourpassword"}])
  end

end
