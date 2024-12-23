## Telematic Applications

# Email Lab

*Academic year 2024-2025*

---

## Introduction

Due to privacy concerns, instances of the user ID and student ID have been
replaced by `<uid>` and `<nia>` in text and `$UID`, `$ID`, and `$NIA` in
commands. Other addresses and/or names were hidden as well where it seemed
appropriate.

* `ID=0$UID`
* `NIA=100$UID`

Some of the environment variables can be set by running the `env_set.sh`
script. Don't forget to run it with `. env_set.sh` so the environment variables
are applied to your session.

## Part 1: Email sending

### 1.1. Start a `telnet` session

Simple enough, just run the indicated command:

```bash
telnet localhost 25
```

The server responded with

```
220 it003.lab.it.uc3m.es ESMTP Postfix
```

### 1.2. Identify as localhost with `HELO`

Running the command

```
HELO localhost
```

I got the response

```
250 it003.lab.it.uc3m.es
```

### 1.3. Use ESMTP after `HELO`

It seems that it is possible to use ESMTP, as sending the following command

```
EHLO localhost
```

Returned a positive response:

```
250-it003.lab.it.uc3m.es
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250-DSN
250 CHUNKING
```

### 1.4. Maximum message size

The maximum message size accepted seems to be `10240000` bytes, as advertised
in response to the `EHLO` command.

### 1.5. Send an email to your address on the lab machines

Now is where things start getting interesting. After identification, we can
start specifying options. First, the **From**:

```
MAIL FROM:<uid>@lab.it.uc3m.es
```

With a positive response:

```
250 2.1.0 Ok
```

Then, the first and only recipient:

```
RCPT TO:<uid>@lab.it.uc3m.es
```

With another positive response:

```
250 2.1.5 Ok
```

And then the contents of the email:

```
DATA
From: <uid>@lab.it.uc3m.es
To: <uid>@lab.it.uc3m.es

This is a sample email.
.
```

Note the final line with the empty dot, which signals the end of the data.

The response was positive:

```
250 2.0.0 Ok: queued as B43F040B
```

Then, in a new terminal, we can run `mail` and enter the `p` command to see the
received email:

```
X-Original-To: <uid>@lab.it.uc3m.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lab.it.uc3m.es;
        s=mail; t=1731602086;
        bh=U7xOtGWHPtijWhlGnSSVvi/bBe2oEewNvQwd6H5aARM=;
        h=From:To:Date:From;
        b=HY7Fm+zQPqR/9vzZcw0uWoNFtfHp++3LD3O7cAtYdVN1LEADMLykdvKwmqBkyUhLW
         PUZS2ZJ3KJyJQxRGMlT1B3tcU8K67RMl/qaUkpcHdlKZWFLJfj+N2/Ncak1AqHu0Wk
         vlnzZg2lKPUt1Vkzah2P+1jZM4CzL4UzesyuSN3U=
From: <uid>@lab.it.uc3m.es
To: <uid>@lab.it.uc3m.es
Date: Thu, 14 Nov 2024 17:30:53 +0100 (CET)

This is a sample email.
```

Three of those headers were added by the SMTP server: `X-Original-To`,
`DKIM-Signature`, and `Date`

### 1.6. Send an email to your personal address

A similar procedure as before was followed, changing the *to* addresses to
`<nia>@alumnos.uc3m.es` in the `RCPT TO` command and the `To:` header. The
responses were also positive. More details can be found in the logs.

In this case, the email received was checked on `mail.google.com` through a web
browser, and the full content was downloaded to an `eml` file (can be found in
the `emails` folder)

Upon inspection, we can see that many more headers have been added this time:

* Delivered-To
* Received
* X-Google-Smtp-Source
* X-Received
* ARC-Seal
* ARC-Message-Signature
* ARC-Authentication-Results
* Return-Path
* Received-SPF
* Authentication-Results
* DKIM-Signature
* From
* To
* Message-Id
* Date
* X-TM-AS-GCONF
* X-TM-AS-Product-Ver
* X-TM-AS-Result
* X-imss-scan-details
* X-TMASE-Version
* X-TMASE-Result
* X-TMASE-MatchedRID
* X-TMASE-SNAP-Result

The `Received` header was repeated several times, telling us which servers
processed the message before it got to its destination. Their identities can be
found in the list below in the format `IP (ID)`:

* `2002:a17:906:af14:b0:a9e:e5ae:140d (lx20csp471834ejb)`
* `mx.google.com (ffacd0b85a97d-3821ae4efc6si955442f8f.711.2024.11.14.09.05.08)`
* `(50163404E)`
* `(43DC0404C)`
* `smtp02.uc3m.es`
* `it000.lab.it.uc3m.es (0BFA34A0370)`
* `it003.lab.it.uc3m.es (2CA7A434)`

There are several ways of uniquely identifying a message. In this case, the one
used is the `Message-Id` header, which contains a unique identifier for the
message. Its value was `20241114170433.2CA7A434@it003.lab.it.uc3m.es`

The 'user' that actually composes the message cannot be determined in this
case, as there is no authentication involved. However, the machine where the
message originated can be seen in the headers, and by doing some digging into
what actual user was logged in at the time of sending the message, an
authorized system administrator may be able to determine who actually
composed a message.

### 1.7. Send an email to several recipients

> **Note**
>
> As the number of repetitive commands was starting to grow, and timeouts were
> becoming more annoying, I decided to write down all commands I needed in a
> text file and sending them all at once using `netcat`. The sequences can be
> found in the `cmds` folder, while the results can be checked in the `logs`
> folder.

The easiest way to send an email to multiple recipients is to specify them via
multiple `RCPT TO` commands. The `To:` or `cc:` headers can also contain all
addresses for added clarity.

The message will be very similar to the previous one.

The following sequence of commands was sent:

```
EHLO localhost
MAIL FROM:$UID@lab.it.uc3m.es
RCPT TO:$NIA@alumnos.uc3m.es
RCPT TO:$EMAIL2
DATA
From: $UID@lab.it.uc3m.es
To: $NIA@alumnos.uc3m.es, $EMAIL2

This is a sample email.
.

```

And was met with a positive response (full details in the logs)

SMTP does **not** support processing commands in batch, but they *can* be sent
all at once, for examply by copying and pasting from a file or by using
`netcat`. However, the server will process them one by one.

### 1.8. Experimental headers

The procedure was similar to the previous sections.

#### 1.8.1 Custom header

The following `DATA` was sent in this email (removing the secondary recipient
in this case)

```
From: $UID@lab.it.uc3m.es
To: $NIA@alumnos.uc3m.es
X-Myheader: My_custom_value

This is a sample email with experimental headers.
```

When viewed with `mutt`, the header **did not show up in the interface**.

#### 1.8.2 `X-Mailer`

As some classmates had gotten different results, I tried using their headers.
The experimental header `X-Mailer` is widely used, and when including it in the
headers, it could be seen in `mutt` next to the rest of the headers.

Here is the data sent in this case:

```
From: $ID@lab.it.uc3m.es
To: $ID@lab.it.uc3m.es
X-Mailer: My_custom_value

This is a sample email with experimental headers.
```

## Section 2: MIME

### 2.9. Send an email using MIME

By adding some extra headers, an email in `quoted-printable` encoding could be
uused in order to add spanish accented characters. The data sent was the
following:

```
From: $ID@lab.it.uc3m.es
To: $ID@lab.it.uc3m.es
Subject: =?ISO-8859-1?Q?Env=EDo_de_notas_provisionales?=
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Este es un email de ejemplo usando codificaci=F3n quoted-printable
```

Even in `mutt`, all special characters were correctly printed.

If we wanted to send a line over 76 characters long, we would have had to split
it in multiple lines, with a `=` character at the end of each line (character
76) and the continuation starting at the first character of the next line.

### 2.10 Multipart message

The global `Content-Type` header we added in the previous section had to be
modified to specify a type `multipart/mixed` and a boundary. The boundary I
chose was `-myBoundary`, including a `-` sign to avoid conflicts with any
base64 encoded content. The global `Content-Transfer-Encoding` was no longer
necessary.

After the headers and the blank line, the content starts. However, no
information is interpreted until the first boundary is found: it must be
a line starting with two hyphens, followed by only the boundary name:

```
---myBoundary
```

Then, the content for that section can start. Several headers can be included
right after the boundary line, including a new `Content-Type` and
`Content-Transfer-Encoding`. This is not mandatory if the content is plain
ASCII, but it *is* necessary in order to encode non-ASCII text or other data
such as pictures, video or audio.

In the case of attaching an image, the following headers were used right after
the boundary line:

```
Content-Type: image/jpeg
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=cool_image.jpg;
```

The first two are required for the image to be decoded properly, while the last
one adds information about where to display the image at the receiving end and
what the name of the file is.

The entire sequence sent to the SMTP server and its response can be found in
the `cmds` and `logs` directories, including one preliminary test made to check
the base64 encoding before adding it to a multipart message.

This email was sent to the `@alumnos.uc3m.es` email address in order to easily
see the results on a web browser.

### 2.11

The first of these requirements was already completed in section 2.9.

I will use both transfer encodings (`quoted-printable` and `base64`) in the
same email on two different headers: The `From` header will use
`quoted-printable`, while the `Subject` will use `base64`.

I chose to use `quoted-printable` encoding for the `From`. Unfortunately, my
name doesn't have any non-ASCII characters anywhere in it, so I had to use
someone else's name.

In the `Subject` field, I chose to write a part of a famous quote in chinese
in order to test the `base64` encoding, using `UTF-8`.

The mentioned headers looked like this:

```
From: =?ISO-8859-1?Q?Pedro_S=E1nchez?= <$ID@lab.it.uc3m.es>
Subject: =?UTF-8?B?5pep5LiK5aW95Lit5Zu944CC546w5Zyo5oiR5pyJ5Yaw5r+A5reL?=
```

The full sequence of commands and the SMTP server responses can be seen in the
`cmds` and `logs` directories.

The output was as expected, and in `mutt` the headers looked like this:

```
From: Pedro Sánchez <<uid>@lab.it.uc3m.es>
Subject: 早上好中国。现在我有冰激淋
```

## Section 3: Notification and Security

### 3.12 Send an email requestion DSN

The DSN request was specified in the `RCPT TO` SMTP command by adding
`NOTIFY=[SUCCESS|FAILURE|DELAY]` at the end of the line, as specified in [RFC
3461][rfc3461] section 4.1. In my case, I added all three options, resulting
in a `RCPT TO` line as follows:

```
RCPT TO:$NIA@alumnos.uc3m.es NOTIFY=SUCCESS,FAILURE,DELAY
```

The email was sent following the same procedures as before. The full contents
can be checked in the `cmds` folder.

After sending the email and getting the `Ok` response from the SMTP server, the
sender inbox (`<uid>@lab.uc3m.es`) was checked using `mutt`, and an inbound
message was found with the subject `Successful Mail Delivery Report`, which
reported a successful delivery of the message. The full contents of the email
can be found in the `emails` folder.

### 3.13. TLS security

In this section, simple emails were sent *with* and *without* TLS encryption,
while capturing the TCP packets and their contents using wireshark, listening
on interface `lo` and port `25`. The commands used to connect to the server as
well as the sequences sent to them can be found in the executable scripts in
the `cmds` folder.

#### 1.13.1. Email without TLS

The script `[3.13.1-send-no-tls.sh][cmd3.13.1]` was used to send a simple email
to a server, piping the sequence of SMTP commands with `netcat`. This can also
be done manually by entering the SMTP commands through `telnet`:

```sh
telnet localhost 25
```

The communication between server and client was captured using `tcpdump`.  The
captures were saved as `.pcap` files in the `[caps][caps]` directory, while the
packet contents were printed to the terminal using the `-A` flag. The following
much simpler command can be used to produce the command line output:

```bash
tcpdump -i lo port 25 -A
```

As expected, the whole contents of the SMTP conversation could be seen in plain
text. The following is an extract from the output of `tcpdump` containing the
commands sent to the SMTP server.

```txt
17:22:08.750494 IP localhost.44500 > localhost.smtp: Flags [P.], seq 1:251, ack 1, win 65495, options [nop,nop,TS val 211228481 ecr 211228481], length 250: SMTP: EHLO localhost
E...0v@.@..R............=?._a.m......".....
...A...AEHLO localhost
MAIL FROM:<uid>@lab.it.uc3m.es
RCPT TO:<uid>@lab.it.uc3m.es
DATA
From: <uid>@lab.it.uc3m.es
To: <uid>@lab.it.uc3m.es
Subject: Test with no TLS

This is a test email sent with no encryption between SMTP server and client
.
QUIT
```

The full output of `tcpdump` can be checked in the logs.

#### 1.13.2. Email with TLS

The script `[3.13.2-send-with-tls.sh][cmd3.13.2]` was used to send a simple
email to a server, piping a sequence of SMTP commands to a connection using
`openssl`. This can also be done by manually entering the sequence of commands
after starting the connection with the same command:

```sh
openssl s_client -starttls smtp -crlf -connect localhost:25
```

The communication between server and client was captured using `tcpdump`. The
captures were saved as `.pcap` files in the `[caps][caps]` directory, while the
packet contents were printed to the terminal using the `-A` flag.

As expected, this time the communication between server and client could not be
simply read from the packets sent, as it was encrypted.

The following is an extract from the output of `tcpdump` corresponding to the
client sending the server some data. All we can see is gibberish.

```txt
17:51:50.629604 IP localhost.52176 > localhost.smtp: Flags [P.], seq 331:411, ack 1510, win 65454, options [nop,nop,TS val 213010361 ecr 213010360], length 80: SMTP
E....B@.@.80.............z~=.........x.....
..G...G...........E6......R#...K........,..e..5...~8E....`....H..,/WZ..........ojP..D...
17:51:50.629813 IP localhost.52176 > localhost.smtp: Flags [P.], seq 411:688, ack 1510, win 65454, options [nop,nop,TS val 213010361 ecr 213010360], length 277: SMTP
E..I.C@.@.7j.............z~..........=.....
..G...G........Ej.S.........<4.y..b#O/... .H..@.....+'.6.wp..>....*....B.Y..w.....q..p0.7..M.$.....3m.<.68K.?....i.Q....fA.(.|...^cD...i..Q..-..........#N..AZ...9.c....({........{...b..r.a....C.
```

As usual, the full output can be checked in the logs.

#### 1.13.2b (Extra) Watching from the outside

The TLS secure connection is only started between initial client and server,
meaning their communication is encrypted, but once the receiving server has to
relay this email to its destination, the encryption may or may not be
encrypted. **This is not end-to-end encryption**

As we can see by watching port 25 on the interface `eth0` of the local machine,
even while using TLS to communicate with the SMTP server on the local machine,
this server does not encrypt its communication with the next server, which in
this case appears to be at `lm000.lab.it.uc3m.es`. The following is an extract
from the capture using `tcpdump`, where all the data previously sent to the
SMTP server at `vit100` using TLS encryption is sent in plain text to the next
SMTP server.

```text
17:51:50.816536 IP6 vit100.36866 > lm000.lab.it.uc3m.es.smtp: Flags [P.], seq 150:610, ack 276, win 64525, options [nop,nop,TS val 2158226899 ecr 1478819873], length 460: SMTP: Received: from localhost (localhost [127.0.0.1])
`.,....@ .. ...
.......P .. ...........).......^/";A....[......
....X%.!Received: from localhost (localhost [127.0.0.1])
	by vit100.lab.it.uc3m.es (Postfix) with ESMTPS id B4439280336
	for <<uid>@lab.it.uc3m.es>; Fri,  6 Dec 2024 17:51:50 +0100 (CET)
From: <uid>@lab.it.uc3m.es
To: <uid>@lab.it.uc3m.es
Subject: Test with TLS
Message-Id: <20241206165150.B4439280336@vit100.lab.it.uc3m.es>
Date: Fri,  6 Dec 2024 17:51:50 +0100 (CET)

This is an email sent with TLS encryption between SMTP server and client
.
QUIT
```

The full output can be seen in the logs.

### 3.14. Server AUTH

The local email server (`localhost:25`) does not support the `AUTH` command, as
it's not advertised when using `EHLO`. Trying to send the server an `AUTH`
command returns the following message:

```text
503 5.5.1 Error: authentication not enabled
```

The full interaction can be seen in the logs.

The `AUTH` command offers a way for a client to indicate an authentication
mechanism to the server, perform the exchange for said authentication
mechanism, and optionally negotiate a security layer. (from [RFC 2554][rfc2554])

> **Note**
>
> The `smtp.uc3m.es` server doesn't support `AUTH` either.

[rfc3461]: https://datatracker.ietf.org/doc/html/rfc3461#section-4
[rfc2554]: https://datatracker.ietf.org/doc/html/rfc2554
[caps]: caps/
[cmd3.13.1]: cmds/3.13.1-send-no-tls.sh
[cmd3.13.2]: cmds/3.13.2-send-with-tls.sh

