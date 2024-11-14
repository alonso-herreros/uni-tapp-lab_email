## Telematic Applications

# Email Lab

*Academic year 2024-2025*

---

## Part 1: Email sending

> **Note**
>
> Instances of the user ID and student ID have been replaced by `<uid>` and
> `<nia>` for privacy.

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
responses were also positive. Check the logs for details.

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

* 2002:a17:906:af14:b0:a9e:e5ae:140d (lx20csp471834ejb)
* mx.google.com (ffacd0b85a97d-3821ae4efc6si955442f8f.711.2024.11.14.09.05.08)
* (50163404E)
* (43DC0404C)
* smtp02.uc3m.es
* it000.lab.it.uc3m.es (0BFA34A0370)
* it003.lab.it.uc3m.es (2CA7A434)

There are several ways of uniquely identifying a message. In this case, the one
used is the `Message-Id` header, which contains a unique identifier for the
message. Its value was `20241114170433.2CA7A434@it003.lab.it.uc3m.es`

The 'user' that actually composes the message cannot be determined in this
case, as there is no authentication involved. 

