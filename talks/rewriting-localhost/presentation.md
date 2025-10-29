# Rewriting Localhost
A Modern Approach to Dev Environments

**Nathan Hessler**

---

## The Traditional Way

```shell
rails server
```

Visit: [localhost:3000](http://localhost:3000)

---

## The Problem with localhost

* Port focused: 3000, 3001, 4000, 5432
* Cookie & Session Issues
* CORS headaches
* HTTPS testing

---

## A Little Preamble

---

## TLD (Top Level Domain)

Top Level Domains are things like .com, .net, .org, etc... There are nearly 1600 TLDs and growing.

That said, there are some special domain that we'll be focused on today.

---

## Special Domains

* .localhost (localhost)
* .local
* .test
* .dev

---

## Special TLDs - .localhost, .test

In 1999, the Internet Engineering Task Force (IETF) reserved the DNS labels **localhost**, **example**, **invalid**, and **test** so that they may not be installed into the root zone of the Domain Name System.

The reasons for reservation of these top-level domain names is to reduce the likelihood of conflict and confusion. This allows the use of these names for either documentation purposes or in local testing scenarios.

<small>[Wikipedia: .localhost](https://en.wikipedia.org/wiki/.localhost)</small>

---

## Special TLDs - .local

The Internet Engineering Task Force (IETF) reserves the use of the domain name label **.local** as a special-use domain name for hostnames in local area networks that can be resolved via the Multicast DNS name resolution protocol.

<small>[Wikipedia: .local](https://en.wikipedia.org/wiki/.local)</small>

Apple's Bonjour and Linux's Avahi use this to discover devices like printers on your network.

---

## Special TLDs - .dev

**.dev** is a top-level domain name operated by Google Registry.

Web developers have been using .dev top-level domains within their internal networks for testing purposes for a long time. However, after Google acquired the TLD, such environments have stopped functioning on some modern web browsers.

<small>[Wikipedia: .dev](https://en.wikipedia.org/wiki/.dev)</small>

Google originally bought it in 2014 to protect it for internal development use, but made it publicly available in 2019.

---

## Use **.test** for Local Development

Given what we just learned:

* **.localhost** and **.test** are permanently reserved by IETF
* **.localhost** is too long to type
* **.dev** is now a public TLD (can cause conflicts)
* **.local** is for mDNS (Bonjour/Avahi)

---

## Who remembers **pow**?

**pow** was a shell scripted solution written by Basecamp to allow for local **.dev** domains for Rails apps. It was fairly plug and play in how it worked making it easy to install and use.

That said, the last update was over 8 years ago, and it is now part of the GitHub public archive. It also runs into the problems of using the **.dev** TLD.

[pow](https://github.com/basecamp/pow)

---

## Modern Solutions

Now that we understand the special domains and the history...

Let's look at what we can use **today**.

---

## Puma-dev

The spiritual successor to pow!

```shell
$ brew install puma/puma/puma-dev
$ sudo puma-dev -setup
$ puma-dev -install
$ puma-dev link path/to/project
```

[puma-dev](https://github.com/puma/puma-dev)

---

## Puma-dev: The Easy Path

* It just works! All-in-one solution
* Handles DNS configuration automatically
* Automatic HTTPS
* Very easy to manage and use

Visit [vane.test](https://vane.test)

---

## Puma-dev: The Limitation

* **Only works for Rack apps using Puma server**
  * Rails 5.0+ uses Puma by default
  * Sinatra, Roda, etc. need Puma gem
* No Docker support
* If you need more flexibility...

---

## Beyond Rack Apps

When you need to support:
* Multiple languages/frameworks
* Docker containers
* More control over your setup

You'll need to build your own stack:
**DNS Config + Reverse Proxy**

---

## DNS Config Options

Two approaches to resolve custom domains locally:

* **/etc/hosts**
  * Edit system hosts file
  * One entry per domain

* **dnsmasq**
  * Set it once
  * works for all `*.test` domains

---

## /etc/hosts Example

Edit the `/etc/hosts` file to add IP domain pairs:

```shell
$ sudo pico /etc/hosts
```

```shell[11]
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1       localhost
255.255.255.255 broadcasthost
::1             localhost

127.0.0.1       vane.test
```

---

## dnsmasq Setup

Install and configure dnsmasq for wildcard DNS:

```shell
$ brew install dnsmasq
```

edit `/opt/homebrew/etc/dnsmasq.conf`:

```
address=/test/127.0.0.1
```

Create `/etc/resolver/test`:

```
nameserver 127.0.0.1
```

```shell
$ sudo brew services start dnsmasq
```

---

## Reverse Proxy Options

Once DNS is handled, choose your reverse proxy:

* **Caddy** - Easy, automatic HTTPS
* **nginx** - More complex, production-ready

---

## Caddy: The Easy Choice

Perfect for multi-language dev environments with minimal setup.

```shell
$ brew install caddy
$ caddy trust
```

Edit `/opt/homebrew/etc/Caddyfile`:

```caddyfile
vane.test {
  tls internal
  reverse_proxy localhost:3000
}
```

---

## Rails: Allow Custom Host

Edit `config/environments/development.rb`:

```ruby
Rails.application.configure do
  # ... other config ...

  config.hosts << "vane.test"
end
```

This tells Rails to accept requests from your custom domain.

---

## Caddy Outcomes

* Automatic HTTPS (just works!)
* Simple configuration
* Framework/language agnostic
* Docker supported
* Great for local development

Visit [vane.test](https://vane.test)

---

## Caddy: Vane with Docker

```caddyfile
docker.vane.test {
  tls internal
  reverse_proxy localhost:3001
}
```

---

## Caddy: This Presentation

Caddy can also serve static files directly:

```caddyfile
presentation.test {
  tls internal
  root * /Users/nathan/Projects/nhessler/rewriting_localhost
  file_server
}
```

Visit [https://presentation.test](https://presentation.test)

---

## Caddy: Services that talk to each other

```caddyfile
provider.test { # elixir & phoenix
	tls internal
	reverse_proxy localhost:4010
}

client-one.test { # node and astro
	tls internal
	reverse_proxy localhost:4011
}

client-two.test { # node and astro
	tls internal
	reverse_proxy localhost:4012
}
```

---

## Caddy: Services under the same domain

```caddyfile
exmexconf.test {
  tls internal

  # Serve static interest page
  handle_path /interest* {
    root * /Users/nathan/Projects/nhessler/exmexconf/exmex/interest
    file_server
  }

  # Serve Astro dev server for everything else
  handle /* {
    reverse_proxy localhost:3211
  }
}
```

---

## nginx: The Production Choice

More complex setup, but great if you already use nginx in production.

```shell
$ brew install nginx
```

Edit `/opt/homebrew/etc/nginx/servers/myapp.test`:

```nginx
server {
  listen 80;
  server_name vane.test;

  location / {
    proxy_pass http://localhost:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
  }
}
```

---

## nginx Outcomes

* HTTPS support available (requires more setup)
* Framework/language agnostic
* Docker supported
* **Mirrors production setup** - great for testing
* More configuration options/control

---

## Choosing Your Path

**Rack apps only?**
→ **puma-dev** (easiest, all-in-one)

**Multiple languages + want easy HTTPS?**
→ **dnsmasq + Caddy**

**Want to mirror production nginx setup?**
→ **dnsmasq + nginx**

**My choice:** dnsmasq + Caddy

---

## The End

**Thank You**

---

## RBQ Conf

sign up to stay in the loop at [rbqconf.com](https://rbqconf.com)

