# Email Assignment 


## Support Materials

* "On-line" man pages: `telnet`,  `mutt`, `mail`

* Simple Mail Transfer Protocol (**SMTP**) - RFC5321

* Multipurpose Internet Mail Extensions (**MIME**):  
  * Part One: Format of Internet Message Bodies (RFC2045)
  * Part Two: Media Types (RFC2046)

* An Extensible Message Format for Delivery Status Notifications – RFC 3464

## Introduction

We will use the local email server that is running in the Telematics laboratory machines: `localhost` and as a client `telnet`. 
An email address is associated to this server: `uid@lab.it.uc3m.es`, where `uid` can be obtained using the `id` command in a terminal.

We will start testing the SMTP protocol with different sending options, then we will test message composition using MIME and finally
notifications and security mechanisms. 

## Email sending

#### 1.	Start a session with the email server using `telnet`:
```
~> telnet localhost 25
```

A welcome message should be returned by the email server identified by the code `220`.

#### 2.	Now the server waits for the host identification that has started the connection. Identify as localhost in the `HELO` message.

#### 3.	Is it possible to change for using ESMTP after the `HELO` message? How would you do?

#### 4.	What is the maximum message size that is accepted by the server? How do you obtain this value?

#### 5.	Send a message to your email address in `localhost` from your same email address. What headers are added by the SMTP server?

> Note: `mail` can be used to check the received emails.

#### 6.	Send a message to your UC3M email address and check the headers in the received messsage: 
*  Are they different from those in the previoues point?
*  What servers have processed the message to reach its destination?
*  How is the message identified in every server? 
*  What would it need in order to know what user actually composes the message?
  
#### 7.	Send an email to several recipients. How is the procedure? Is it possible to transmit groups of SMTP commands in batches without waiting for a response to each individual command? Why? 

#### 8.	Try to add experimental headers in the mail `(X-)`. How are the headers shown in the received mail, for instance, using `mutt`?

## Multipurpose Internet Mail Extension (MIME)

#### 9.	Send an mail to your address in `localhost` from your same email address using MIME.

#### 10. Compose a multi-part message that involves two parts, e.g. a plain text encoded with ISO-LATIN1 (ISO-8859-1) and a file (e.g. .dot, .png).
What headers must be added? How are the parts separated?

#### 11. Use a content transport encoding for the `Subject`. Try using both `"Quoted Printable"` and `"Base 64"`.


## Notification and Security

#### 12.	Send an email indicating that you want to receive a delivery status notification (DSN) message.
What options must be added to the SMTP commands for this? What MIME type is assigned to the DSN messages?


####  13.	Send an email using STARTTLS and capture the traffic using `tcpdump` (or `Wireshark`). Compare both traffic captures (with and without STARTTLS). What is the difference between them? 

There are functionalities to secure the email exchange using TLS (*Transport Layer Security*); so a protected session can be established. Can try this option using:
```
~> openssl s_client –starttls smtp -crlf -connect localhost:25
```

#### 14.	The `AUTH` command is used to authenticate the client by sending the user name and password. Does local email server support this option? What advantages offer the use of this command?