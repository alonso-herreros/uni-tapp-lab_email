[English version](readme_en.md)

# Práctica de Correo Electrónico

## Material de soporte

* "On-line" man pages: `telnet`,  `mutt`, `mail`

* Simple Mail Transfer Protocol (**SMTP**) - RFC5321

* Multipurpose Internet Mail Extensions (**MIME**):  
  * Part One: Format of Internet Message Bodies (RFC2045)
  * Part Two: Media Types (RFC2046)

* An Extensible Message Format for Delivery Status Notifications – RFC 3464

## Introducción 
Para el desarrollo de esta práctica utilizaremos como servidor el servidor de correo local disponible en las máquinas del laboratorio de Telemática: `localhost`, 
y como cliente `telnet`. Disponéis de una dirección de correo asociada a este servidor que sigue el formato `uid@lab.it.uc3m.es`, donde el `uid` puede obtenerse
ejecutando el comando `id` en un terminal.

Comenzaremos probando el protocolo SMTP con distintas opciones de envío, luego probaremos la composición de mensajes utilizando MIME, las notificaciones de recepción de mensajes y terminaremos con los mecanismos de seguridad. 

## Envío de correos electrónicos

#### 1.	Iniciad una sesión con el servidor de correo utilizando telnet:
```
~> telnet localhost 25
```

Debe visualizarse en la respuesta el mensaje de bienvenida devuelto por el servidor de correo identificado con el código `220`.

#### 2.	Ahora el servidor espera la identificación del host que ha iniciado la conexión, identificaros como localhost en el `HELO`.

#### 3.	¿Es posible cambiar a utilizar ESMTP después del `HELO` inicial? ¿Cómo lo haría?

#### 4.	¿Cuál es el tamaño máximo de mensaje admitido por el servidor? ¿Cómo se obtiene?

#### 5.	Probad a mandaros un mensaje a vuestra dirección en `localhost` desde vuestra misma dirección  ¿Qué  cabeceras de traza añade el servidor SMTP?

> Nota: podéis utilizar el comando mail para comprobar los correos disponibles

#### 6.	Probad a enviar un mensaje a vuestra dirección de correo de la Universidad.  Comprobad las cabeceras del mensaje recibido 
*  ¿Son diferentes a las visualizadas en el punto anterior?
*  ¿Entre qué servidores ha circulado el mensaje hasta alcanzar su destino?
*  ¿Cómo se podría identificar el mensaje en cada uno de los servidores? 
*  ¿Qué necesitaríamos para saber qué usuario es él que realmente compuso el mensaje?
  
#### 7.	Enviad un correo a varios destinatarios ¿Cuál es el procedimiento? ¿Es posible pasar una sucesión de comandos encadenados (para indicar los diferentes destinatarios) sin esperar una respuesta para cada comando? ¿Por qué? 

#### 8.	Probad ahora a introducir cabeceras experimentales en el correo `(X-)` ¿Cómo se ven en el correo recibido con un lector de correos, por ejemplo, con `mutt`?

## Extensiones multi-propósito de correo de Internet (MIME)

#### 9.	Mandad un mensaje a vuestra dirección en `localhost` desde vuestra misma dirección utilizando MIME.

#### 10.	Componed un mensaje multi-parte con dos partes alternativas, por ejemplo, una en texto plano con ISO-LATIN1 (ISO-8859-1) y otra un fichero (p.ej., .dot, .png)  ¿Qué cabeceras es necesario añadir? ¿Es necesario añadir algo más para separar las partes?

#### 11.	Utilizad una codificación de transporte de contenido para el `Subject`. Probad a utilizar tanto `"Quoted Printable"` como `"Base 64"`.

## Notificaciones y seguridad

#### 12.	Enviad un correo indicando que se desea recibir por parte del emisor un mensaje de notificación de estado de entrega (DSN) que debe ser proporcionado por el servidor SMTP de la dirección de correo destino.
Indique qué opciones ha añadido a los comandos SMTP para conseguir dicho objetivo ¿Qué tipo MIME se asigna a los mensajes DSN?

####  13.	Enviad un email usando STARTTLS y capturad el tráfico intercambiado con  `tcpdump` (o `Wireshark`). Comparad dicha captura con un envío de correo sin STARTTLS ¿Cuál es la diferencia? 

Existen varias funcionalidades para añadir seguridad al intercambio de correos electrónicos con SMTP. Concretamente, para proporcionar confidencialidad, se puede utilizar la opción STARTTLS, que es uno de los comandos soportados por ESMTP, y que permite elevar la sesión de correo actual a una sesión protegida criptográficamente con TLS (*Transport Layer Security*).
Para probar esta opción podéis conectaros al servidor de correo local utilizando:
```
~> openssl s_client -starttls smtp -crlf -connect localhost:25
```

#### 14.	El comando `AUTH` se utiliza para autenticar al cliente frente al servidor enviando su nombre de usuario y password ¿Soporta el servidor de correo local dicha opción? ¿Qué beneficio aporta el uso de este comando?
