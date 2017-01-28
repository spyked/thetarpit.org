---
postid: 053
title: I wrote a blog.
date: November 6, 2016
author: Lucian Mogoșanu
tags: meta
---

As [previously promised][new-tar-pit], the new Tar Pit[^1] is almost
done. It's not quite there yet, and considering the usual pace of the
blog's affairs, it might take a month or two before it goes online --
besides, the non-technical reader will experience virtually zero change
in reading experience; so I dare guess that this news isn't even that
interesting. However, I wrote a blog! and despite this development
having begun before the initial announcement, and despite its duration
of a few additional months, it has all gone in perfect accordance to the
initial plan.

Given all this, and moreover, given this rare occasion of working with
sane tools[^2] I feel compelled to share my experience with the reader
and do some post-design examination on the topic.

First of all, the Tar Pit Lisp Blog Scaffolding (LBS) is based upon a
fundamental data structure, which I have at some point uninspiredly
decided to name `blist`[^3]. A `blist` is conceptually very similar to a
dynamic symbol table, that is, a binding between a name and a
value. Almost everything from blog posts to templates to tags are
representable as `blist` objects, and thus all that the LBS needs to do
is convert source objects such as Markdown files or [CL-WHO][cl-who]
templates into this intermediate representation, and then forth into the
target representation, which in our case happens to be plain ol' HTML.

This approach has the advantage of uniformity: metadata (e.g. post
identifiers, the author(s), the date of publication) as well as the
actual data (e.g. post content) are all represented using the name-value
associations within a particular unit, e.g. a post or a page. Given
this, the blog programmer is left with no option but[^4] to manipulate
`blist`s as he or she wishes, for example by translating the body from
Markdown to HTML or generating a whole new body based on existing
metadata, such as for creating lists of references.

The heavy lifting is of course still done by CL-WHO and Pandoc, with
some help from [CL-PPCRE][cl-ppcre] and some other useful bits which
help keep the whole castle in one place. And despite the system's
heterogeneity, the design is anything but a mash-up of arbitrary tools.

As far as development effort goes, I believe the whole thing took much
less than fifty hours of implementation put together, plus around ten
hours of thinking and reading the imported libraries. In fact most of
the time went into learning Common Lisp[^5], debugging and testing being
a close second and actual writing and refactoring occupying a third
place.

The close-to-final result is publicly available on [GitHub][github] --
for now on a separate branch, but I expect it to converge towards the
master as soon as I deem it to be ready for use in production. And make
no mistake, "ready for use in production" is equivalent to "done", not
unlike Roman aqueducts, the Great Wall of China and Shakespeare's works
are "done"[^6]. And when it's here, you'll see it -- soon!

[^1]: Tarp it!

[^2]: Who ever had the impudence to state that
    [software sucks][software-engineering-ii]?

    As a matter of fact, making software that doesn't suck isn't
    difficult. It only requires doing engineering for a clear purpose,
    or rather, stemming from a cause worthy of consideration, rather
    than coding for the sake of code; and it requires accepting that the
    only true [freedom][freedom-is-slavery] derives from understanding,
    that is, reading the code, rather than from mindless `import
    universe` statements; and it also requires a very specific mindset
    that makes all the difference between profession and mere
    circle-jerking.

    Not difficult at all...

[^3]: I can't say I remember exactly why I gave it this name. It is
    certainly a sort of unordered list addressable by arbitrary
    identifiers, which makes it in fact a dictionary, which makes the
    current hash table-based implementation quite well-suited to the
    task.

[^4]: Paradoxically!

[^5]: By which I mean exactly Common Lisp, not a style of programming,
    not macros, not algorithms and not design patterns, although each of
    these subjects must be understood in order to fit everything in
    head. On the other hand the fact that so many programming systems
    copied Common Lisp makes it easy to recognize certain patterns in
    their pure form.

[^6]: But Lucian, your blog is nowhere near the technical and artistic
    innovation blah-blah-yadda!

    ... or not unlike how a bowl of stew is done, m'kay? A given
    artifact does not have to be novel nor in any way special in order
    to be "done"; more so that nowadays' vast majority of software is in
    the vast majority of cases anything but done, to everyone's chagrin.

[new-tar-pit]: /posts/y03/050-the-new-tarpit.html
[software-engineering-ii]: /posts/y02/049-the-myth-of-software-engineering-ii.html
[software-engineering-iii]: /posts/y03/04e-the-myth-of-software-engineering-iii.html
[freedom-is-slavery]: /posts/y03/04f-freedom-is-slavery.html
[cl-who]: http://weitz.de/cl-who/
[cl-ppcre]: http://weitz.de/cl-ppcre/
[github]: https://github.com/spyked/thetarpit.org
