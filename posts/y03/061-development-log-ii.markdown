---
postid: 061
title: The Tar Pit development log [ii]
date: April 17, 2017
author: Lucian Mogoșanu
tags: tech
---

In our [previous log entry][development-log-i] we set the goal of
hosting The Tar Pit on its own HTTP server, as opposed to a
general-purpose setup, and then using it to serve dynamic content,
e.g. comments. We skimmed through a few Common Lisp HTTP server
implementations -- why reinvent the wheel when we can steal the
blueprints? -- and found at least two such implementations that are
minimal enough to be useful for us: Sven Van Caekenberghe's
[s-http-server][s-http-server] and Tomo Matsumoto's
[cl-http-server][cl-http-server]. To continue, we'll give a brief
overview of one of the former and afterwards get a better look at the
latter.

Let's begin with s-http-server. Its interface is fairly simple to use,
as stated in the README: creating, starting and stopping servers as well
as setting handlers for given URIs are all a piece of cake,
except... the whole thing doesn't really work. On a first glance, we
notice that the `start-server` method calls
`s-sysdeps:start-standard-server`, while `stop-server` calls
`s-sysdeps:kill-process`, which denotes a confusion between the two
abstractions[^1]. Then we notice s-sysdeps contains its own
general-purpose `stop-server` routine, so we can make that public and
then use it (instead of `kill-process`) to stop the HTTP server.

All this turns our server into a working machine until trying to serve a
static file, any file at all. Leaving aside the fact that for some
reason SLIME doesn't integrate too well with SBCL's `add-fd-handler`
(`sb-impl::serve-event` needs to be called manually to trigger the
handling routine), the HTTP connection handler[^2] ends up trying to
write a sequence of raw bytes to a stream that expects characters. I'm
not willing to put up with that; what other bugs await in the rabbit
hole of s-http-server? If you're interested, find out yourself and let
us know.

cl-http-server is very similar to s-http-server, only it's somewhat
heavier on the dependency side: it depends among others on Bordeaux
Threads, CL-FAD, flexi-streams and trivial-shell, which themselves have
some dependencies, which make our in-depth exploration somewhat
difficult. There's also no tutorial on the cl-http-server page, so we're
going to go through the first steps ourselves. Let us proceed.

Assuming that all the packages are in place and ASDF knows how to load
them[^3], let's begin by importing the library:

~~~~ {.commonlisp}
CL-USER> (asdf:load-system :cl-http-server)
...
CL-USER> (in-package :cl-http-server) ; ... for convenience
~~~~

Now that we have `cl-http-server` loaded, how do we use it? The examples
directory has a file called [test.lisp][cl-http-server-test] which gives
us a basic idea. Also, looking at the definition of `start-server`
(`server.lisp`), we see that the default value of the `server` argument
is the result of a call to `make-server`, the constructor of
`server`. Let's take a look at how a `server` object looks:

~~~~ {.commonlisp}
(defstruct server
  (host                   "127.0.0.1"             :type string)
  (port                   8080                    :type integer)
  ...
  (public-dir             "/tmp/cl-srv/public/"   :type string)
  ...
  (session-save-dir       "/tmp/cl-srv/session/"  :type string)
  ...
  (thread))
~~~~

There are quite a few fields whose meaning we don't understand exactly
quite yet, but we notice there is a `public-dir` which can be used to
serve static files[^4], some fields related to session management[^5]
and finally some configuration related to logging, cookies and garbage
collection. We don't care about most of them right now, but we'd like to
be able to do the bare minimum of serving The Tar Pit in its current
form, which means that we can set `public-dir` to wherever the site
is. Let's give it a try:

~~~~ {.commonlisp}
CL-HTTP-SERVER> (defparameter *my-server*
                  (start-server (make-server :public-dir *lbs-site*
                                             :port 8000)))
*MY-SERVER*
CL-HTTP-SERVER> (describe *my-server*)
#S(SERVER..
  [structure-object]

Slots with :INSTANCE allocation:
...
~~~~

Where `*lbs-site*` is the path to The Tar Pit
[Lisp Blog Scaffolding][i-wrote-a-blog] site defined in
[config.lisp][config-lisp].

Now, pointing the browser at `localhost:8000` displays us a "Default
index page" message, which is actually the same page as that returned by
the `index-page` function, which we notice is called from
`default-page`. Either way, by trying out `localhost:8000/index.html` we
actually get the index of our site. This is pretty incovenient, since
we'd like `/` (the root) to point to this page. Before looking at how to
do that, let's get an overview of a few of the abstractions that
cl-http-server offers us:

* `(get-page path)`: retrieves the page associated with `path`
* `(set-page path fn)`: associates the page given by the handler `fn`
  with `path`
* `(page-lambda (args ..) body)`: macro that creates a handler to be
  used in conjunction with `set-page`
* `(defpage name (args ..) body)`: alias for `set-page` and
  `page-lambda`; read the code
* `(page path args)`: sort of an alias for `get-page`; read the code
* `(serve-file path)`: pretty self-explanatory

We notice that `default-page` tries to get the page named `default`
(which, intuitively enough, maps to the URI `/default`). If it finds a
definition for it, then it serves it; otherwise, it returns the "Default
index page" message. So all we need to do is to define it using
`defpage`:

~~~~ {.commonlisp}
CL-HTTP-SERVER> (defpage default ()
                  (serve-file
                   (merge-pathnames #p"index.html"
                                    (namestring (public-dir)))))
~~~~

Pointing the browser to `/` or `/default` should throw up the index page
now.

Now we want to test dynamic stuff, so let's say that we wanted to create
a dynamic page, `/my-page`, that increments a variable on each access
and displays it. First, let's define the variable:

~~~~ {.commonlisp}
CL-HTTP-SERVER> (defparameter *my-lispy-var* 0)
*MY-LISPY-VAR*
~~~~

Now let's define the page. For convenience, we'll use cl-http-server's
`html` utility function that returns a very simple HTML page with a
title and a body. We won't need this for the actual blog, since we
already use CL-WHO for templating, but for this prototype it should
suffice. We will wrap the page definition in a `progn` that does two
things: it increments `*my-lispy-var*` and it calls a templated `html`
which formats the value of `*my-lispy-var*` to a string:

~~~~ {.commonlisp}
CL-HTTP-SERVER> (defpage my-page ()
                  (progn
                    (incf *my-lispy-var*)
                    (html :body
                          (format nil "Lispy var: ~s"
                                  *my-lispy-var*))))
~~~~

Now let's suppose we want to do more sophisticate things. Let's say that
we want to do some processing of the URL of `/my-page`, e.g. if we want
to search for a specific page when `/my-page/a` is entered[^6], etc. For
this, cl-http-server provides us with the `uri-path` function, which
tokenizes the URL by slashes and it allows us the access the nth token
in the URL. Let's put this into an example:

~~~~ {.commonlisp}
CL-HTTP-SERVER> (defpage my-page ()
                  (progn
                    (incf *my-lispy-var*)
                    (html :body
                          (format nil
                                  "URL suffix: ~s, lispy var: ~s"
                                  (uri-path 2)
                                  *my-lispy-var*))))
~~~~

Now pointing the browser to `/my-page` will display "URL suffix: NIL,
lispy var: 7"; then if we point it to `/my-page/a`, it will display "URL
suffix: "a", lispy var: 8" and so on.

Now we can stop the server (not that we would ever need to):

~~~~ {.commonlisp}
CL-HTTP-SERVER> (stop-server *my-server*)
T
~~~~

To sum things up, I am quite satisfied. At some point I will need to do
some basic benchmarking and stress testing to make sure that the server
performs well under basic workloads, but even as a test setup this is
quite satisfactory. The achievement here is that we've managed to throw
together a basic server that adheres to the fits-in-head principle,
i.e. even if the length of this post is above the tarpitian average, it
still fits within the bounds of decency.

In the following instances of our series we will adapt The Tar Pit LBS
to output posts and their metadata as S-expressions and we will
integrate the HTTP server component to serve said S-expressions as web
pages from what will be a database of blog items.

[^1]: Servers are processes that listen, i.e. wait for incoming
    connections on a given network address, e.g. an IP/port pair. That
    said, looking at the server as an abstract data structure, as
    defined for example by the `s-sysdeps` package, it contains other
    items such as one or more sockets, a reference to the connection
    handler routine and others. Thus servers and processes, as defined
    in this framework of ours, lie at two distinct levels on the
    abstraction ladder.

[^2]: `handle-http-server-connection` calls
    `handle-one-http-request-response` which does all the bookkeeping,
    e.g. calls the particular resource handler for a given URL.

    For static files, the resource handler points to
    `host-static-resource`, wherein our pesky bug lies.

[^3]: Many people use Quicklisp for this. If you've been reading The Tar
    Pit, you know that I don't think much of the `apt-get` method when
    it comes to software engineering. This is why The Tar Pit is a
    monolithic beast, containing all the software needed to run it save
    for SBCL.

    Anyway, you can have a look at [blog.lisp][blog-lisp] to see how the
    blog loads its dependencies at boot time. It's ugly, but what can I
    say, it hasn't failed me so far.

[^4]: Why not multiple public dirs? No idea. Depending on how things go,
    I might have to hack this.

[^5]: I am unsure of how useful this is, but... we'll see.

[^6]: This is, of course, a potential security issue, but fortunately
    cl-http-server already does some URL preprocessing on GET requests,
    which at least gives us some level of guarantee that we're working
    with a sane URL, e.g. an URL that doesn't contain double periods.

[development-log-i]: /posts/y03/05c-development-log-i.html
[s-http-server]: https://github.com/svenvc/s-http-server/
[cl-http-server]: https://github.com/tomoyuki28jp/cl-http-server
[blog-lisp]: https://github.com/spyked/thetarpit.org/blob/master/blog.lisp
[cl-http-server-test]: https://github.com/tomoyuki28jp/cl-http-server/blob/master/examples/test.lisp
[i-wrote-a-blog]: /posts/y03/053-i-wrote-a-blog.html
[config-lisp]: https://github.com/spyked/thetarpit.org/blob/master/config.lisp.example
