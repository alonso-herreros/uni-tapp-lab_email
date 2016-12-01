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


## Notifications and Security

#### 12.	Enviad un correo indicando que se desea recibir por parte del emisor un mensaje de notificación de estado de entrega (DSN) que debe ser proporcionado por el servidor SMTP de la dirección de correo destino.
Indique qué opciones ha añadido a los comandos SMTP para conseguir dicho objetivo ¿Qué tipo MIME se asigna a los mensajes DSN?

####  13.	Enviad un email usando STARTTLS y capturad el tráfico intercambiado con  `tcpdump` (o `Wireshark`). Comparad dicha captura con un envío de correo sin STARTTLS ¿Cuál es la diferencia? 

Existen varias funcionalidades para añadir seguridad al intercambio de correos electrónicos con SMTP. Concretamente, para proporcionar confidencialidad, se puede utilizar la opción STARTTLS, que es uno de los comandos soportados por ESMTP, y que permite elevar la sesión de correo actual a una sesión protegida criptográficamente con TLS (*Transport Layer Security*).
Para probar esta opción podéis conectaros al servidor de correo local utilizando:
```
~> openssl s_client –starttls smtp -crlf -connect localhost:25
```

#### 14.	El comando `AUTH` se utiliza para autenticar al cliente frente al servidor enviando su nombre de usuario y password ¿Soporta el servidor de correo local dicha opción? ¿Qué beneficio aporta el uso de este comando?


### 1. Determine the IP address of the machine www.mec.es. 

### 2. Check which machine has the IP address 193.110.128.199. 

### 3. Find out the name and IP address of the DNS servers of the domain abc.es and say which of them is primary and which is secondary. 

### 4. Obtain the SOA registry of the domain abc.es, first, by asking the local DNS and, second, by asking the primary server of the abc.es domain. Verify that in one case, the response is authoritative and in the other, it isn't. 

### 5. If you had a problem with the DNS of abc.es and you had to send an e-mail to its administrator, to what address would you send it? 

### 6. Determine the name and IP address of the mail server of the administrator referred to in the previous question

### 7. How long will the IP address of www.vanguardia.es remain in the cache of your local DNS? Ask your local DNS for this address several times in succession. What do you observe in the TTL of the resource registry? 

### 8. Now ask the same to a root server (for example, J.ROOT-SERVERS.NET with IP address 192.58.128.30) and check in the reply packet that this server does not accept the recursive mode. 

