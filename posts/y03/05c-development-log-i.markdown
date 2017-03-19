---
postid: 05c
title: The Tar Pit development log [i]
date: March 19, 2017
author: Lucian Mogoșanu
tags: tech
---

I was [recently reminded][contravex] that my blog lacks a comments
box. This is not a new issue: I've admitted a while ago that I
[might have to fix this][commenting], and while the long-awaited magical
solution hasn't even been on the table (or nowhere near the horizon, for
that matter), The Tar Pit has been going through
[various issues][new-tarpit] which
[led to changes][i-wrote-a-blog]. Long story short, the blog is now
generated through a small tool[^1] mostly written and entirely
maintained by yours truly.

This event opens up an opportunity, that is, the chance to write a
blogging software that is the result of pragmatic engineering, as
opposed to [undisciplined enthusiasm][software-engineering-ii]: the blog
can be specified as an [unambiguously useful][unambiguous-usefulness]
tool with a clear purpose, and more importantly a clear set of
limitations, stemming from the fact that the concept of blog pertains to
an immutable set of functionalities. Everything outside that immutable
set represents functionality of anything else but a blog.

The problem of what constitues an X, where X is a conceptual artifact of
computer science and software engineering, is uncoincidentally a very
hard problem -- arising from what we know as
[abstraction hell][iadul-abstractizarii], which means that the concept
of blog is not unambiguous in and of itself, etc. And this is where we,
and by we I mean this is where this series of posts comes in.

This development log proposes to walk the reader through the process of
building a blog, and at the end hopefully to elucidate the definition of
blog, at least from the author's point of view.

The principal cause of this development log is the
following. Intuitively, making a blog from scratch is not a difficult
intellectual endeavour. This intuition given, any intellectual with the
patience to get their hands dirty in matters of techne[^2] should be
able to make their own or otherwise steal from another and understand on
their own. This possibility given, any braindead blog solution stamped
and approved by a Committee of Blogs near you, e.g. Wordpress, becomes
useless, except maybe for the plebeians who will forever live in abuse
of Gutenberg's goodwill. Thus if we can, then, in the Pythons' own
words, let's get on with it.

This lengthy introduction left behind us, let's start with a few
requirements. In order for a blog post to display comments without much
fuss (e.g. manually updating the page), the HTTP server needs a dynamic
page generation component. Thus the server must not only serve some
static content, but it must also grab some content from a database[^3],
somehow combine it with the static content, then dynamically generate
the HTML page from the two items and only then serve it. This is easy to
achieve through templating, and it's why PHP was created. This is also
how The Tar Pit works, only the template-to-HTML-page conversion is done
by me before the content reaches the site, instead of being generated
dynamically by a HTTP server.

Since The Tar Pit lives in the world of Common Lisp, what we need is a
way to serve HTML pages generated on-the-fly using the HTTP protocol. As
a bonus, it would be nice to have a component that can resolve blog
paths in a more intelligent way. For example, we could access not only
`/posts/y42/12c-post.html`, but also
`/posts/y42/12c-post`, and also, why not `/posts/12c`. In any
case, on a HTTP GET request, a server should be able to grab a post in
template form (i.e. not yet fully[^4] converted to HTML), manipulate the
dynamic parts as needed, convert the template to HTML and then serve the
resulting page. On a HTTP POST request, the same server should be able
to add comments to the database, but this something we will get into
later.

The Common Lisp world already has a bunch of [HTTP servers][cliki]
available for our benefit. The hard part consists in figuring out which
one is more suitable for our purpose. Ideally, I would like to integrate
into The Tar Pit a software that brings along a minimal set of
dependencies and comes with as few features as possible; features which
I can then grab from other software if I decide I need them -- the
essential definition of HTTP server being software that receives a
request and responds according to the
[Hypertext Transfer Protocol][http-rfc]. On a first glance all the
aforementioned servers seem equally suitable; but let's do a more
thorough examination:

* **AllegroServe**: Portable HTTP server implementation written by Franz
  Inc. Portable in that it works on multiple Common Lisp
  implementations, an aspect I am not sure I am interested in, as SBCL
  seems more than enough. Pro: it's self-contained. Con: the unneeded
  components would require trimming: The Tar Pit
  [will not use SSL][https] in the foreseeable future; no external CGI
  is required; CL-WHO is already used as a templating language; virtual
  hosts are unneeded, as that functionality can be already provided by
  e.g. Apache. Other than that, it doesn't seem bad.
* **Antiweb**: "Antiweb is a webserver written in Common Lisp, C, and
  Perl by Doug Hoyte and Hoytech". Had I wanted C and Perl, I would have
  used Apache.
* **Araneida**: The web server behind CLiki, the files are still
  available [on the web][araneida]. Pro: minimal set of external
  dependencies. Con: same as AllegroServe; for example The Tar Pit will
  never have a web-based administration interface, and thus it will
  never use web-based authentication mechanisms; I also doubt it will
  ever use cookies.
* **dwim.hu**: Common Lisp utilities written by [dwim.hu][dwim-hu],
  among them being a HTTP server. Looking through the ASDF file for
  dependencies, `hu.dwim.quasi-quote.xml+hu.dwim.quasi-quote.js` doesn't
  strike me as very sane. Clearly not a first choice.
* **house**: Written as part of the DEAL project (whatever that is), but
  otherwise [its own thing][house]. Pro: it seems very small: about
  eight files, not more than about 300 lines each. Con: the list of
  dependencies is not insignificant. It does probably deserve a second
  look though.
* **Hunchentoot**: The alpha and omega of Common Lisp HTTP servers
  nowadays, it seems. It's like a shwarma with everything, and thus I'd
  like to avoid using it unless I'm out of other options.
* **jarw-inet**: Utility library for various protocols, including HTTP,
  written by [John A.R. Williams][jarw]. Unfortunately the links on the
  project page are dead, and google has been unable to help me find any
  code.
* **s-http-server**: Simple HTTP server written by Sven Van
  Caekenberghe. Code is available on [GitHub page][s-http-server]. Pros:
  it *seems* small (most of the code is bundled up in one file); it
  seems done. Cons: it depends on a few other libraries written by
  Caekenberghe; it contains some SSL support code which needs to be
  eliminated. So far it *seems* like a good candidate for The Tar Pit's
  web serving component, but I need to give it a more detailed look
  before passing judgement.
* **sw-http**: Allegedly fast HTTP web server written (and abandoned, it
  would seem) by Lars Rune Nøstdal. A mirror is available on
  [GitHub][sw-http]. Pro: It *seems* small and not too bloated. Cons: I
  don't want to know what `bootstrap-types.lisp` does; one of the
  dependencies is the library of Alexandria; another is the library of
  CL utilities; yet another of the dependencies (also an utility
  library, also written by Nøstdal) is abandoned and nowhere to be
  found. Not sure I want to try this out.
* **teepeedee2**: "Fast webserver for dynamic pages". Available on
  [GitHub][teepeedee2]. Much in the vein of Hunchentoot, huge and with a
  heavy dependency burden.
* **toot**: Result of an attempt to cut stuff from Hunchentoot. It's
  smaller, but not small enough, the list of dependencies being hefty. I
  tried it out and it works, but for the amount of things it imports, it
  doesn't even support setting a custom 404 page. Requires a lot of
  trimming and modifications; I'm not convinced it's a good choice, but
  in lack of a better alternative, I'd dive into it.
* **Wookie**: Yet another Hunchentoot fork. Async and all, nothing
  interesting to see here.

In addition to the list on CLiki, I've found a few more by googling:

* **cl-http**: Also known as the Common Lisp Hypermedia Server. Probably
  one of the first web servers ever written, at least in the Lisp
  world. Unfortunately all the official sites and FTP mirrors pointed to
  by Google are dead.
* **cl-http-server**: Distinct from the cl-http above. Written by Tomo
  Matsumoto and available on [GitHub][cl-http-server]. It looks similar
  to s-http-server in most respects.
* Some frameworks written on top of Hunchentoot, and some frameworks
  written on top of the frameworks written on top of Hunchentoot,
  turtles all the way down to? I'm not even considering them.

I think this is enough for us to get an idea of what Common Lisp has to
offer in terms of HTTP servers. In the worst case, we know that there is
a lot of code to cut from, making this method the modern equivalent of
building our own web server. Assuming that's not the case, then: AServe
is a powerhouse that I'm willing to consider in lack of more minimal
working solutions; s-http-server and cl-http-server sound promising;
house might be worth trying; the rest would only be worth taking into
consideration in the worst case scenario described previously.

But that's enough for today.

[^1]: Embedded in the source code that is available
    [on GitHub][github]. Given that GitHub is a venue owned by actors
    having a dubious relationship to [freedom][is-slavery], I don't
    expect this to last forever. Thus at some point I will host my own
    public code repository with blackjack and hookers, only without the
    blackjack.

[^2]: Which in any civilized world everywhere and everywhen means any
    intellectual, period. This is Leonardo's most important lesson:
    you're not [human][worth-to-humanity] unless you're willing to
    understand the important things that your lazy reptilian brain
    otherwise refuses to,
    i.e. [the miracles that matter][the-miracles-that-matter].

[^3]: The pedantic will point out that static files served by the HTTP
    server are usually stored in an operating system's filesystem, which
    itself is a database.

[^4]: For example we wouldn't run Pandoc on every page request, as that
    would be unnecessary and also a big performance killer.

[contravex]: http://www.contravex.com/2017/02/18/the-robot-tax/#comment-54657
[commenting]: /posts/y00/023-maybe-i-was-wrong-about-that-commenting-thing.html
[new-tarpit]: /posts/y03/050-the-new-tarpit.html
[i-wrote-a-blog]: /posts/y03/053-i-wrote-a-blog.html
[github]: /posts/y00/006-the-tar-pit-on-github.html
[is-slavery]: /posts/y03/04f-freedom-is-slavery.html
[software-engineering-ii]: /posts/y02/049-the-myth-of-software-engineering-ii.html
[unambiguous-usefulness]: /posts/y03/052-on-the-unambiguous-usefulness-of-tools.html
[iadul-abstractizarii]: http://lucian.mogosanu.ro/bricks/despre-inteles-iadul-abstractizarii/
[worth-to-humanity]: /posts/y01/032-your-worth-to-humanity.html
[the-miracles-that-matter]: http://trilema.com/2014/the-miracles-that-matter/
[cliki]: http://archive.is/fDkg9
[http-rfc]: https://tools.ietf.org/html/rfc2616
[https]: /posts/y03/05b-https-war-declaration.html
[araneida]: https://www.common-lisp.net/project/araneida/araneida-release/
[dwim-hu]: http://dwim.hu
[house]: https://github.com/Inaimathi/house
[jarw]: http://www.jarw.org.uk/lisp/inet.html
[s-http-server]: https://github.com/svenvc/s-http-server
[sw-http]: https://github.com/cpc26/SW-HTTP
[teepeedee2]: https://github.com/vii/teepeedee2
[cl-http-server]: https://github.com/tomoyuki28jp/cl-http-server
