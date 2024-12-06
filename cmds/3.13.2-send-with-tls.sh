CONTENT="EHLO localhost
MAIL FROM:$ID@lab.it.uc3m.es
RCPT TO:$ID@lab.it.uc3m.es
DATA
From: $ID@lab.it.uc3m.es
To: $ID@lab.it.uc3m.es
Subject: Test with TLS

This is an email sent with TLS encryption between SMTP server and client
.
QUIT"

echo "$CONTENT" | openssl s_client -starttls smtp -crlf -connect localhost:25
