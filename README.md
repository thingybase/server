> [!WARNING]
> **PROPRIETARY SOFTWARE – NO UNAUTHORIZED USE**
> **Plain English:** This is the private property of **Rocketship, LLC (DBA "Thingybase.com")**. You can look, but you can't touch — no copying, modifying, or using this code without explicit permission.
> **Legalese:** Unauthorized reproduction, distribution, modification, public display, or use of this software, in whole or in part, is strictly prohibited and constitutes a violation of U.S. and international intellectual property laws. Violators will be prosecuted to the maximum extent permitted under applicable law.
>
> 📧 For licensing inquiries, contact: [contact@thingybase.com](mailto:contact@thingybase.com)
> 📜 Full license terms: [LICENSE.md](./LICENSE.md)

# README

Server application for Thingybase.

## Principles

Keep the following in mind when developing patterns.

### Avoid JavaScript

Do as many things on the server as possible. If you don't think you can do it on the server, you'll need to prove why. Then ask at least two other people if they can think of ideas for how to do it on the server. After that, check with the owner of this repo if it can be done on the server. Only then should you do it in JavaScript.

Yes, this is hard. It requires a lot of thinking. If you figure it out though, it's worth it. Your future self will thank you for it.

Here's one war story. When I was building out the PDF label feature, I needed a way to preview the PDFs in the browser. I tried using `<embed/>`, `<iframe/>`, and `<object/>` tags, but it did all sorts of weird stuff on all the different clients. In Safari it would hang the browser because it couldn't free up the PDF renderer when you hit the back button (Turbolinks).

My first thought was, "dang! I guess I have to use PDF.js", so I added the `pdfjs-dist` package to the `package.json` file and all hell broke loose. First I had to figure out how to load the file within webpack. After spending an hour searching, I found a few old articles that pulled it off. Of course none of them worked and I kept getting loading errors. "It must be the webpacker pipeline" I told myself. I tried upgrading it a version. That didn't work. Then I upgraded it to a pre-release version. That didn't work. I found a beta build of rails where somebody got it working, spun it up, and that worked. Unfortunately that didn't translate into this app. Finally I found a few React packages where people said it simply won't work plug-and-play.

I questioned the meaning of life, went for a walk, and felt like a complete failure.

But then I remembered, "can I do this on the server?". I then thought, "what if I render the PDF as a PNG to preview the thing?". I did some digging around in the MiniMagick libraries and found that it was possible. It wasn't super straightforward. There were some issues loading the PDF and increasing the DPI, but within an hour I was able to figure it out without banging my head against the wall in an asset pipeline that works in a bunch of different ways that renders things completely differently in different browsers.

SVGs were another version of that. Getting them to work in dark/light mode for the icons would have required a pretty decent amount of hoops to jump through on the client, so instead I did the hoop jumping on the server.

There are more stories, but you get the idea. You can probably do most things on the server.

### No part is the best part

You're an engineer. You get paid to build complicated things. The more complicated it is the more impressive it will look. Right? WRONG!

Mark Twain once said, "I didn't have time to write you a 1 page letter so I wrote you a 5 page letter instead". This applies to whatever you build. Simplify it. DRY it up. Just please don't try to impress anybody with complexity. If you don't have to build it that's even better. If you have to build it, do it in a way that's DRY, reusable, and ideally open-sourceable (the sign of proper decoupling).

You'll see simplicity all over that's not impressive. Everything is stored in a boring PostgreSQL RDBMS. The application is deployed to Heroku. The app is built on Rails using Turbolinks. Boring. Boring. Boring.

### Keep data structures simple

All interactions between the client and server are done via very simple RESTful endpoints.

## Setup

To get this project going on macOS, you'll need:

* Docker for Mac
* Homebrew

To get it set up run:

```
$ brew bundle
$ bundle
$ yarn
$ gem install foreman
```

Then to get the party started:

```
$ compose up -d
$ foreman start
```

Open the website in your browser and it's off to the races.

## Deployment

The server is deployed to Heroku. It's super boring and lame, but it's also very easy and we don't have to pay an ops team for a long time or worry about patching servers.

To deploy:

```
$ git push heroku master
```

Wasn't that easy?
