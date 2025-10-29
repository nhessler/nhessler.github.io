---
title: Rewriting Localhost
sub_title: A Modern Approach to Dev Environments
author: Nathan Hessler
theme:
  name: light
---

The Problem with localhost:####
===

* Port focused 3000, 3001, 4000, 5432
* Cookie & Session Issues
* CORS headaches
* HTTPS testing

<!-- end_slide -->

<!-- jump_to_middle -->

A Little Preamble
===

<!-- end_slide -->

TLDs (Top Level Domain)s
===

Topl Level Domains are things like .com, .net, .org, etc... There are roughly 1443 TLDs as of May 2025 and growing. that said, there are some special domains that we'll be focused on today.


- .localhost (localhost)
- .local 
- .test
- .dev

<!-- end_slide -->

Special TLDs (localhost, test)
===

In 1999, the Internet Engineering Task Force (IETF) reserved the DNS labels **localhost**, **example**, **invalid**, and **test** so that they may not be installed into the root zone of the Domain Name System. 

The reasons for reservation of these top-level domain names is to reduce the likelihood of conflict and confusion. This allows the use of these names for either documentation purposes or in local testing scenarios.

[*](https://en.wikipedia.org/wiki/.localhost)

<!-- end_slide -->

Special TLDs (local)
===

The Internet Engineering Task Force (IETF) reserves the use of the domain name label **.local** as a special-use domain name for hostnames in local area networks that can be resolved via the Multicast DNS name resolution protocol.

[*](https://en.wikipedia.org/wiki/.local)

<!-- end_slide -->

Special TLDs (dev)
===

**.dev** is a top-level domain name operated by Google Registry. 

Web developers have been using .dev top-level domains within their internal networks for testing purposes for a long time. However, after Google acquired the TLD, such environments have stopped functioning on some modern web browsers.

[*](https://en.wikipedia.org/wiki/.dev)

google originally bought it in 2014 to protect it for internal development use, but made it publicly available in 2019.

<!-- end_slide -->

pow
===

Pow was a shell scripted solution written by basecamp to allow for local .dev domains for rails apps. It was fairly plug and play in how it worked making it easy to install and use. that said, last update was over 8 years ago, and it is now part of the github public archive. it also runs into the problems of using the .dev TLD

[pow](https://github.com/basecamp/pow)
[puma-dev](https://github.com/puma/puma-dev)

<!-- end_slide -->

Modern Options
===

* manual
* nginx
* Caddy

<!-- end_slide -->

Manual
===

edit the `/etc/hosts` file to add a IP domain pair to the file for routing

```shell
$ sudo pico /etc/hosts
```

<!-- end_slide -->

/etc/hosts
===

```shell {11} +line_numbers
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost

127.0.0.1 vane.localhost
```

<!-- end_slide -->

Manual Outcomes
===

visit `example.test:4000` to verify it works
visit `service.test:4001` to verify it works

* works for mulitple domains
* address cookie colisions
* does not get away from using ports
* does not support SSL


<!-- end_slide -->

Nginx
===

Nginx can be installed via brew

```shell
$ brew install nginx
```

still need to edit `/etc/hosts` as was done in manual process

edit `/opt/homebrew/etc/nginx/servers/example.test`
edit `/opt/homebrew/etc/nginx/servers/service.test`

<!-- end_slide -->

example.test (nginx file)
===

```
server {
  listen 80;
  server_name example.test;

  location / {
    proxy_pass http://localhost:4000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```

<!-- end_slide -->

development.rb (in project)
===

```ruby
require "active_support/core_ext/integer/time"

Rails.application.configure do

  #...Code...

  config.hosts = ["vane.test"]
end
```

<!-- end_slide -->

Nginx Outcomes
===

* start/restart the nginx service
* start your project

visit http://vane.test to verify it works

* advantages of manual process
* https support is available
* no port in url **SO CLEAN!!**
* framework/language agnostic
* docker supported 
  * listen/open port you define in your servers file

<!-- end_slide -->

Caddy
===

caddy can be installed via brew

```shell
$ brew install caddy
```

still need to edit `/etc/hosts` as was done in manual process

edit `/opt/homebrew/etc/Caddyfile`

edit `config/environments/development.rb`

```shell
caddy trust
```

<!-- end_slide -->

Caddyfile
===

```
vane.test {
	tls internal
	reverse_proxy localhost:3000
}
```

<!-- end_slide -->

Caddyfile Outcomes
===

* start/restart the caddy service
* start your project

visit http://vane.test to verify it works

* advantages of nginx process
* https support is so easy!

<!-- end_slide -->

Puma-dev
===

puma-dev can be installed via brew

```shell
$ brew install puma/puma/puma-dev
$ sudo puma-dev -setup
$ puma-dev -install
$ puma-dev link path/to/project
```

[puma-dev](https://github.com/puma/puma-dev)

<!-- end_slide -->

Puma-dev Outcomes
===

visit https://vane.test to verify it works

* it just works!
* very easy to manage and use for rack based apps
* only works for rack apps
* no docker support 

<!-- end_slide -->

Credits
===

* [Custom domains and SSL in Rails development](https://avohq.io/blog/custom-domains-ssl-in-rails-development)


