---
title: "What Happens When You Type a URL Into a Browser"
date: 2020-09-11T11:13:47-04:00
---

I started listening to the ["How the Internet Works" episode][1] of the Ladybug [podcast][2] today.
They set out to answer the technical interview question:

> What happens when you type a URL into a browser?

Before I listened to their explanation I pressed pause.
This is my attempt to explain the process without doing any research, like I was answering an interview question.
(Yes, I did type the example commands into my terminal to get the output.)

EDIT: Never mind.
I spent way more time on this and went into way more detail than I could ever do speaking off the cuff.
This is one of the pitfalls of technical interviews.
I don't have a lot of professional experience standing in front of a white board and explaining things extemporaneously.
Instead, I write documents that attempt to thoroughly explain the required information while remaining accessible to a broad audience.

* * *

Typing a URL into a browser is something we do all the time and, although it is appears to be simple, a lot of things happen at different levels of the technology stack.

Browsers perform a lot of actions in the address/combo bar itself.
As you are typing it tries to guess what you want to do by:

- Matching patterns of URLs or words you enter with pages from your browsing history
- Querying your default search provider and return the top results
- Querying DNS for domain names that match what you have typed so far

The combination and behavior of these functions vary from browser to browser but they all do something like this.
The results of these queries show up as options for you to choose from.
Let's say you don't select any of these suggestions and press enter when you finish typing.
Next, the browser will try to make a request to a web server based on what you typed.
To do that, it goes through another two processes:

<ol>
  <li>URL resolution</li>
  <li>Content negotiation<label for="content-negotiation" class="margin-toggle sidenote-number"></label><input type="checkbox" id="content-negotiation" class="margin-toggle"/><span class="sidenote">I'm using the term "content negotiation" loosely here.
  The narrowest technical definition of content negotiation is the process where the client and the server use accepts headers and content types to determine the encoding and/or the content of the response body.
  I am using it to mean "the client and the server figure out what they need from each other" before the response body is processed by the client.</span></li>
</ol>

URLs have a structure:

```
<protocol>://<OPTIONAL subdomain>.<apex domain>.<toplevel domain (TLD)>:<OPTIONAL port>/<OPTIONAL path>?<OPTIONAL query>=<OPTIONAL paramter>
```

The steps a browser takes depends on the parts of the URL you entered.

For example:

```
danhorst.com
```

Has a few more steps than:

```
https://www.danhorst.com
```

URL resolution starts by querying DNS to find an IP address that maps to the the address that was entered.
DNS (domain name service) is a globally distributed network of servers that store what are essentially big lookup tables for all the domains that are registered on the Internet.
Internet infrastructure companies run DNS servers as a part of their operations.
For example, CloudFlare runs 1.1.1.1 and Google runs 8.8.8.8.
When you create a domain using a registrar like, Hover.com or NameCheap, it registers it with the global lists on servers blessed by ICANN (ICANN governs the Internet and I think the acronym is French so I don't know what it stands for exactly).
The records get picked up by other DNS providers from there.
That is why it takes a while for DNS changes to propagate.

The DNS provider your browser uses depends on the network settings of your device.
Those settings can are configured per network adapter so they vary based on which one you are using to access the Internet.
For most people, the DNS service is provided by your Internet Service Provider (ISP).
It can also be manually set to specific provider.
Companies may run internal DNS if they want to control how name resolution works on their internal network.
For example, if you have a VPN for work it may allow you to resolve DNS records that don't exist on the public Internet.

There are different kinds of DNS records: A, CNAME, TXT, MX, etc.
For name resolution, we're primary looking at A (address) records.
CNAME records can be used to specify additional addresses that resolve to a server (I'm not familiar enough with how this works to be able to explain how this works in detail).
MX records have to do with mail routing.
TXT records are used for other metadata.
For example, Google Webmaster Tools asks you to add a unique TXT record to your domain to prove that you control it.

You can query DNS outside of the browser too. I do this when I need to troubleshoot a connectivity issue.

```
~ $ dig danhorst.com +short
104.198.14.52
```

(I use the `+short` output almost all the time.
The default output for `dig` has way more information than I need for checking name resolution.)

Once the browser has an IP address that maps to the domain it initiates a TCP/IP connection to that IP address.
IP stands for "Internet Protocol" and we typically use IPv4 address which take the form of four period-delimited blocks of 1-3 integers e.g. 129.0.0.1, 8.8.8.8 (IPv6 is also a thing but those addresses are so long I never remember what they look like exactly. IPv6 doesn't have a lot of support in the Internet at large.)
If no protocol is specified in the URL, the browser assumes HTTP (Hypertext Transfer Protocol) and attempts to connect to port 80 on the IP address of the server.

You can use `telnet` to check to see if a connection can be made to the specified port for a given IP address:

```
~ $ telnet 104.198.14.52 80
Trying 104.198.14.52...
Connected to 104.198.14.52.
Escape character is '^]'.
```

Or you can use `curl` to check how the server responds:
```
curl -I danhorst.com
~ $ curl -I danhorst.com
HTTP/1.1 301 Moved Permanently
Cache-Control: public, max-age=0, must-revalidate
Content-Length: 37
Content-Type: text/plain
Date: Fri, 11 Sep 2020 07:13:49 GMT
Location: https://danhorst.com/
Age: 32302
Connection: keep-alive
Server: Netlify
X-NF-Request-ID: bd036650-87b5-4e74-8033-06731acad39a-25552555
```

The `-I` parameter tells `curl` to make a HEAD request.
HTTP defines _verbs_ that clients can use to make requests from servers.
The common ones are: GET, POST, and HEAD (PUT, PATCH, and DELETE can be used too but they don't have universal support).
GET requests retrieve content from a web server.
POST requests send content to a web server.
HEAD requests get only the HTTP headers for a given URL.

A web server's response to a client request has three parts: status code, headers, and body.
A HTTP status code is a 3-digit number that describe the response at a high level.
HTTP headers are colon-delimited key-value pairs that contain metadata about the response body that the client uses to process the response and, in some cases, make additional requests.
The response body is the data that is processed and/or displayed by the client.

See `HTTP/1.1 301 Moved Permanently`?
That's an HTTP status code.
We've moved from DNS resolution, which happens at the network layer to content negotiation that happens between the web server and the client.
`301` is an HTTP status code that has a specific meaning.
The 3XX status codes are _redirects_ which means that they tell the client "you need to get the content you are looking for somewhere else".
Thankfully it tells you where to look next via the `Location` header: `https://danhorst.com/`.

Because of this redirect, the protocol has changed from HTTP to HTTPS (the S stands for "secure", or it may have originally stood for SSL, Secure Socket Layer, but that means of encryption was deprecated in favor of TLS, Transport Layer Security, years ago.)
HTTPS uses a pair of public/private encryption keys to ensure that the messages sent between the client and the server are kept private and unaltered in transit.
HTTPS communication is sent over port 443 instead of port 80.

There are two key parts of securing web traffic: a means of validating that the server is what it says it is and a means of encrypting and decrypting the messages being sent.
There are only a few organizations that can establish that a server is trusted they are called Certificate Authorities.
They issue what is called a "root certificate" that forms the base of the chain of trust between organizations to certify that a server is what it says it is.
This takes the form of a "certificate chain" that starts with the root certificate, may include one or more intermediate certificates, and ends with the certificate for the domain associated with a web server.
The important things about a certificate chain are that it:

- Traces back to a known-good root CA
- Is valid for a fixed window of time (typically one year from when it was issued)
- Is valid for a specific domain be it wildcard e.g. `*.danhorst.com` or specific e.g. `www.danhorst.com`

To establish a chain of trust from a web server that will serve traffic for a specific domain you start by generating a Certificate Signing Request (CSR)<label for="cert-management" class="margin-toggle sidenote-number"></label><input type="checkbox" id="cert-management" class="margin-toggle"/><span class="sidenote">Certificate management can be a complicated manual process.
That's why a lot of people prefer setting up something like Let's Encrypt to auto-renew certificates or put web servers behind a load balancer that integrates with Amazon Certificate Manager (or it's equivalent outside of AWS) to avoid this whole mess.</span>.
Generating CSRs, and almost everything else you might want to do with TLS, it handled with specific incantations of `openssl`.
I do this so infrequently I don't remember the details and have written scripts to take the guesswork out of it.
You submit the CSR a certificate authority and they give you back a `<certificate-name>.key` file that contains the private key to store securely on the server and a certificate chain to share with the world.
There are lots of ways to encode the certificate chain but I like to use plain text (X509) so the certificate chain is just a text file with a list of public keys in it (I use a `<certificate-name>.pem` file to do this).
Some web servers expect the root CA to be first and the domain certificate to be last and others are the reverse (don't ask me why).
You may have to experiment to figure how to go from what the certificate authority gave you to what you need for the server to work.

The list of trusted root certificate authorities is managed by the operating system or language runtime of the client<label for="java-certs" class="margin-toggle sidenote-number"></label><input type="checkbox" id="java-certs" class="margin-toggle"/><span class="sidenote">There have been times where I needed to add certificates to a certificate store and explicitly point a Java process to that certificate to avoid errors (this isn't a great time).</span>.
This only becomes a problems when you have a self-signed certificated (not blessed by a root CA) or if you use a more obscure root CA (why would you do this?).

Once a chain of trust is established using the certificate chain<label for="cert-chain" class="margin-toggle sidenote-number"></label><input type="checkbox" id="cert-chain" class="margin-toggle"/><span class="sidenote">It's important to include the _entire_ certificate chain, from the root CA up to the specific cert, or else some clients won't trust it.
There are also ways a certificate can be cross-signed to other authorities, but the specifics are lost on me.</span>, the browser uses the public key provided by the certificate chain to encrypt the communication with the server.
It does this using one of many methods.
There is both the protocol--SSL, TLS 1.0, TLS 1.1, TLS 1.2, TLS 1.3--as well as the "cypher suite" used to perform the encryption.
The client and the server compare lists of available protocols and cypher suites for those protocols and try to find one they both have in common.
It is up to the server administrator to disable weak or defunct protocols and cypher suites on the web server in order to ensure that the connection is secure<label for="cypher-punk" class="margin-toggle sidenote-number"></label><input type="checkbox" id="cypher-punk" class="margin-toggle"/><span class="sidenote">Most of the Internet that we use day to day is served over HTTPS.
Overall, this is a good thing for privacy and security, but it comes with a price: older clients and machines get left behind.
A few weeks ago I started up a netbook for the first time in years and it couldn't make valid HTTPS connections to anything so it was unable to even update it's packages.</span>.
If both the browser and the web server can agree on a supported means of encryption then the request/response cycle can continue.

Let's try accessing the "Location" header value it returns:

```
~ $ curl -I https://danhorst.com/
HTTP/2 301
cache-control: public, max-age=0, must-revalidate
content-length: 41
content-type: text/plain
date: Fri, 11 Sep 2020 07:13:50 GMT
location: https://www.danhorst.com/
strict-transport-security: max-age=31536000
age: 40924
server: Netlify
x-nf-request-id: 160d69b1-c6eb-44e5-af2b-64c14a83d621-3083499
```

Another 301!
I've configured my website to _never_ serve content from the apex domain `danhorst.com`.
The way apex domains are resolved means that there are fewer options for managing how name resolution works for large, complicated, websites.
At least, that's the way it _used_ to be.
I'm short on the specifics, but there was an RFC<label for="rfc" class="margin-toggle sidenote-number"></label><input type="checkbox" id="rfc" class="margin-toggle"/><span class="sidenote">The nuts and bolts of how <em>exactly</em> the Internet is described in specs that are referred to as RFCs (I <i>think</i> that stands for Request for Change but that isn't a great name for a standard that governs something this important.)
I have looked at a few of these but they are dry and difficult to read.
The formatting doesn't help either--it's 80 column fixed width text as if it were old-school terminal output.
I've had better luck reading them via <a href="http://pretty-rfc.herokuapp.com/">Pretty RFC</a>.</span>, I believe it was originally proposed by Amazon--years ago, made to address this problem and it now has broad support.
I chose to follow the outdated guidance of not serving content from apex domains for my personal site but I didn't for [rocketlabdelta.com][3] and I haven't had any issues (not that either site really gets any traffic).

Following the `location` header one more time we get:

```
~ $ curl -I https://www.danhorst.com/
HTTP/2 200
cache-control: public, max-age=0, must-revalidate
content-length: 0
content-type: text/html; charset=UTF-8
date: Fri, 11 Sep 2020 20:09:09 GMT
etag: "53d06608fda472d36b8dae0280615192-ssl"
strict-transport-security: max-age=31536000
age: 1
server: Netlify
x-nf-request-id: 325c0416-d223-4844-9452-7f7737e97a73-8669214
```

We've made it to a page!
2xx status codes mean things are working as expected (4xx are client errors, 5xx are server errors).
Now the browser can process the HTML that is returned (you know it's HTML because of the value of the `content-type` header).
How the browser goes from the HTML document to a web page that you can see and interact with is complicated enough that it deserves it's own article.

[1]: https://www.ladybug.dev/episodes/how-the-internet-works
[2]: /lists/podcasts/
[3]: https://rocketlabdelta.com
