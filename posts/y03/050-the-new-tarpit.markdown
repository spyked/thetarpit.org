---
postid: 050
title: Placing the cornerstone for The new Tar Pit
excerpt: Much like the old one, only slimmer and more maintainable
date: September 18, 2016
author: Lucian Mogoșanu
tags: meta, tech
---

Back when I started this journey I had to make a few decisions of
[a purely technical nature][technicalities]. These decisions shaped the
way this blog looks[^1], the way it is structured[^2], the software it
is based on and the manner in which thoughts are conveyed to the
reader. The first and the second I don't plan to change in the
foreseeable future; the fourth is hard to figure as far as my own mind's
structure is concerned and may change in unknown ways; the third was a
purely arbitrary choice based on things I liked at the time, and will be
discussed here.

In other words, while I am largely satisfied with my blog, the time has
come for me to question the way its so-called "scaffolding" works and
set a new stake in the ground regarding it. This is mostly of interest
to myself, although I hope bloggers reading this will find here a few
bits of experience to integrate into their own.

The Tar Pit has so far used [Hakyll][hakyll] as its backing blog
software. Hakyll is sexy, being made in Haskell, and it's also
customizable, in that it allows me to automatically generate this
particular web-thing you're reading. And while it works without giving
me any outstanding headaches of the time, it has a few problems that
makes it an undesirable tool.

Problem number one (in an arbitrary order) is also its sexiest point,
which is that it works within the Haskell environment. This wouldn't
have been a problem had GHC not gone [the systemd way][ghc]. Alas, it
has, and I do not like it, because it generates among others problem
number two. Problem number two is that the modern Haskell ecosystem has
now for long been riddled with issues such as a packaging hell, which
requires[^3] me to basically reinstall Hakyll whenever I receive a major
update to GHC. More unfortunate is the fact that Hakyll blog
(re)installations are very uneconomical, as good practice requires
setting up a Cabal sandbox that weighs about 500MB of storage space.

Problem number three consists of some bad bits in Hakyll itself, bits
that throw control out of my hands and into the maintainer's[^4]. For
example a few months ago I for some reasons had to go through the
process described in problem number two, which resulted in a new version
of Hakyll popping up in my lap. This was all okay until I figured out
that post identifier strings were no longer parsed properly, because of
some YAML functionality added to the metadata parser. Thus I now had in
my hands a feature that I did not ask for but that I got anyway, that I
couldn't disable and that I had to hack my way around by manually
modifying a large number of files.

Problem number four is the sum of the first three. It's clear to me that
such behaviour cannot go unpunished, as ad-hoc changes in the
specification[^5] are
[the bane of engineering][software-engineering-i]. The only question is
how to go about this in a sane way.

There are actually two[^6] potential solutions to this problem. The
first solution is to fork Hakyll and maintain it myself; the second
solution is to start from a clean slate and build the blog exactly the
way I want it. Guess which one I chose.

The trade-off goes as follows. The first solution is easier to apply in
the short term, but may still end up hurting me in the long term:
Hakyll's entire code base, including libraries, is huge in size and as
the Haskell ecosystem will continue going systemd I will have to go
through pains to keep it up to date while making sure it does what I
want it to. The second solution is quite the opposite: it requires a lot
of work in the short term[^7] but once it's done it's done, just like
real engineering is supposed to work.

So it's about time we applied our [principles][software-engineering-iii]
to this whole thing, isn't it now?

<p style="text-align:center; font-weight:bold;">⁂</p>

From a purely Tarpitian point of view[^8], the software that backs a
blog up, which I will from now on call a (blog) scaffolding, is a
program that takes as input a bunch of files, typically (but not
necessarily) Markdown text files, and spits to the output another bunch
of files that make up the blog you are now reading. This is the abstract
description, which we will refine in the paragraphs to come.

More precisely, files taken as input by The Tar Pit blog scaffolding may
be:

* Template files, which are used to generate pages whose content changes
  over time; this may mean either specific pages (e.g. the blog's
  `index.html`) or types of pages (e.g. a list of posts for each blog
  tag).
* Post files, which are usually written in a lightweight markup language
  such as Markdown, that will be converted to HTML, and on which a
  standard page template will be applied[^9].
* Other files, e.g. CSS files or images, that will be inserted into the
  site as they are.

Template files need to be written in a specific templating language
which can be understood by a processing machine. Post files are a tad
more complicated: their metadata (e.g. title, post identifier) needs to
be parsed, they need to be converted to HTML and then the metadata needs
to be applied as per each template's substitution rules. Other things
happen there, such as the post metadata being collected into a list in
order to be used to e.g. build the post archive, generate one web page
per tag, etc.

We additionally require a few mechanisms to make our lives easier. For
example we need to take all the post files in a directory tree[^10] and
automatically generate the output files in a similar hierarchy; idem for
files residing in a dedicated uploads directory. Optionally we could
have a simple HTTP server to allow us to test the newly generated
site[^11]. As an optimization we could maintain a cache of generated
posts and check for modifications and update only the modified posts as
necessary. There are other features (e.g. RSS feeds), but overall the
above should be enough to have a basic blog running.

After pondering for a while[^12] I have reached the conclusion that the
best trade-off between stability, features and minimalism is the Common
Lisp ecosystem. I had actually considered using Scheme[^13] at first,
but this one lacks all the cool portable libraries that Common Lisp
has[^14], so I decided to stick to the latter.

As far as HTML templating goes, [CL-WHO][cl-who] is both small enough
and usable enough for my purposes, so I'm sticking to that. Directory
walking and file copying can be done using built-in Lisp support. The
thing that I need to do is build a set of operations around these basic
primitives and a small management component to keep track of all the
posts in the blog. This is all scriptable, so no troubles here. I'm also
including [CL-PPCRE][cl-ppcre] to parse tags and post metadata.

The greatest challenge is Markdown-to-HTML conversion. Hakyll uses
[Pandoc][pandoc] for that and as far as I've used it, it works and it
works well, even for extensions such as highlighted code blocks and
MathJax[^15]. As far as I know there are a few Markdown processors
written in Lisp[^16], but I haven't looked at what libraries they depend
on and how compatible they are with Pandoc's Markdown, and figuring this
part out would take quite a bit of time. So for the time being I'm
conceding on using Pandoc, even though it comes from the same Haskell
territory I've decided to abandon.

Things are similar regarding importing a HTTP server. I'm not yet sure
this is worth it, but assuming it were, I would take something such as
[Hunchentoot][hunchentoot] and severely amputate some of its
features[^17]. Until I figure this out I'm using Busybox's
[httpd][busybox-httpd] to serve site files locally.

<p style="text-align:center; font-weight:bold;">⁂</p>

The new Tar Pit blog scaffolding is still very much a work in progress,
and there is no such thing such as an "estimated date of release" for
it. However most pieces are already working, the main aspect I need to
decide on being the interface the scaffolding will expose to the
blogger. There is also the matter of making the code look better, but I
don't expect to spend too much time on this[^18].

So, dear reader, with a bit of luck you will be able to read this after
the nuclear apocalypse will have come to pass and luckily both you and I
will have survived it. All you will need is to find[^19] a Lisp machine
and make only a few modifications to the software in order to be able to
enjoy The Tar Pit in all its horrible splendor.

[^1]: Plain old HTML with a bit of CSS and some JavaScript here and
    there. The latter hasn't proven to be extraordinarily useful, so I
    might decide to remove it at some point.

[^2]: This includes the per-year organization, the tags and the post
    numbering. Yes, the number of bits required to represent the post
    identifier were a consideration, if not for the reader, then for
    myself as an estimation of the number of articles that I will get to
    publish until my expiration. If this overflows at any point, then I
    will have to reconsider my decision, but for now things seem to be
    rather fitting.

[^3]: In a very deterministic manner, also. This makes it not that much
    of a problem, only it has the unfortunate side effect of wasting my
    time when I just want to blog instead of reinstalling software.

[^4]: If you've been using computers for a while now, this will remember
    you of that fundamental piece of software that we do not like, which
    is the Windows operating system.

[^5]: I have no idea if this was part of any spec to Hakyll's author,
    but it also happens that I do not care. It was part of the
    specification for me: post metadata worked in a simple, specific way
    when I started using it, and the fact that it got needlessly changed
    along the way made it break what from my point of view is system
    spec.

[^6]: Of course, there is a third solution, which involves doing nothing
    about the whole thing. This is in fact the modern ostrich approach
    of ignoring problems that affect one, as applied by today's
    political leaders who this way remain somewhat political, but in the
    end lose their leader status.

    As an off-topic footnote and an interesting fact, this is (you
    leftist dumbasses, if I may add this vocation) why democratic
    systems end up putting so-called right-wing extremists in charge:
    because they're the only ones who at least declare to commit to
    change things. That said changes make things worse before they make
    them better is a truley sorry for your lots.

[^7]: Another interesting footnote: building from an approximate scratch
    doesn't involve that much work after all. There is code to read, of
    course, and there is of course code to write. But note that I do not
    need the entire set of functionalities of Hakyll in order to have a
    working Tar Pit.

    Also, since I've set out to rebuild my blog and not the entire
    world, and since I'm doing it one piece at a time, from very clear
    requirements, this has so far been quite an enjoyable road; sort of
    like baking your own cake, if you will.

    Sure, the requirements might change after a while, but this is a
    decision that I would make of my own will, not forced by whatever
    circumstances the world chooses to impose upon me. Yes, this is all
    a matter of agency versus [slavery][freedom-is-slavery], being the
    conquered or the conqueror and all that other metaphorical bullshit
    the average derp won't bother to consider. This is a good for them.

[^8]: As opposed to the "spyked bricks in the wall" view or about any
    other Wordpress-based approach to blogging.

[^9]: The header, footer, etc. that you see on every page on this blog.

[^10]: That is, a directory including sub-directories, à la
    `posts/y[ab]/[postname].markdown`.

[^11]: This is pretty cool, but the trade-off is that it adds a lot of
    complexity. Just think that "HTTP" immediately imports the operating
    system abstraction of socket, the abstraction of the protocol and
    other potentially useful things such as MIME types. The question is
    whether I really want to have this much in the blog scaffolding when
    the production instance is served using Apache.

[^12]: The process of which will not be described in this article.

[^13]: By which I mean Scheme, not Racket. Possibly with some R5RS
    extensions or something of the likes, but anyway, something simple
    enough to get me started.

[^14]: Not that I care too much about portability, mind you. But long
    story short, Common Lisp is a very powerful beast, including among
    others a built-in macro system which I am working on
    understanding. Yes, this *is* a learning experience as well.

[^15]: Which I plan to phase out of the blog once I'm getting rid of
    JavaScript. Really, one shouldn't be forced to execute arbitrary
    code they don't trust on their machine, and I don't want to force
    anyone to disable that at the expense of readability.

    This also applies to the fancy fonts the blog has, but these only
    have a minimal impact on the site's look. Actually, most of the time
    I'm reading the site from w3m and lynx without any issues.

[^16]: [cl-markdown][cl-markdown], [3bmd][3bmd] and there may be others.

[^17]: For example I don't really need threading, asynchronous I/O or
    whatever else it's providing. Sure, these are in principle good to
    have, only not for my purposes.

[^18]: It's not that it looks particularly good at the moment, and it's
    not that it looks too bad either. It could look better, but other
    than that it's just plain Lisp, which makes it readable enough,
    despite haters' misconceptions about the language.

[^19]: Or [build][hardware-future]!

[technicalities]: /posts/y00/002-technicalities.html
[hakyll]: https://jaspervdj.be/hakyll/
[ghc]: /posts/y02/03e-ghc-teaching.html
[software-engineering-i]: /posts/y02/03c-the-myth-of-software-engineering.html
[freedom-is-slavery]: /posts/y03/04f-freedom-is-slavery.html
[software-engineering-iii]: /posts/y03/04e-the-myth-of-software-engineering-iii.html
[cl-who]: http://weitz.de/cl-who/
[cl-ppcre]: http://weitz.de/cl-ppcre/
[pandoc]: http://pandoc.org/
[cl-markdown]: https://common-lisp.net/project/cl-markdown/docs/user-guide.html
[3bmd]: https://github.com/3b/3bmd
[hunchentoot]: http://weitz.de/hunchentoot/
[busybox-httpd]: https://git.busybox.net/busybox/tree/networking/httpd.c
[hardware-future]: /posts/y03/04d-future-of-computing-hardware.html
