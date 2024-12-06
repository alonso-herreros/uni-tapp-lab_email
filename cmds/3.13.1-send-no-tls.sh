CONTENT="EHLO localhost
MAIL FROM:$ID@lab.it.uc3m.es
RCPT TO:$ID@lab.it.uc3m.es
DATA
From: $ID@lab.it.uc3m.es
To: $ID@lab.it.uc3m.es
Subject: Test with no TLS

This is a test email sent with no encryption between SMTP server and client
.
QUIT"

echo "$CONTENT" | nc localhost 25

