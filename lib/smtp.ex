defmodule  SMTPMail  do

  def send do
    gen_smtp_client:send({"whatever@test.com", ["andrew@hijacked.us"],
 "Subject: testing\r\nFrom: Andrew Thompson <andrew@hijacked.us>\r\nTo: Some Dude <foo@bar.com>\r\n\r\nThis is the email body"},
  [{relay, "smtp.gmail.com"}, {username, "me@gmail.com"}, {password, "mypassword"}]).
  end


end
