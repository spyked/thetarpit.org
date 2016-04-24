---
postid: '03e'
title: Glasgow Haskell Compiler no longer suitable for teaching
date: November 8, 2015
author: Lucian Mogoșanu
tags: tech
---

While recently fiddling with the latest version of GHC[^1], I noticed that the
standard [Prelude][haskell-prelude] library now contains a few rather contrived
constructions. For example, this is what querying `foldl`'s type yields:

~~~~
Prelude> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
~~~~

This change is the result of the so-called "[Functor-Applicative-Monad
Proposal][famp]" (AMP), and more specifically the "[Foldable/Traversable
Proposal][ftp]" (FTP), both being proposed and developed to meet a few very
technical issues regarding the standard library. More precisely, the `Monad`
type class naturally inherits `Applicative`, which in turn inherits `Functor`;
additionally, according to FTP, the `Foldable` and `Traversable` classes should
be moved into the base library, thus implying that certain functions, such as
`foldl` above, are then given their most general type signature.

These proposals have a few -- again, purely technical -- advantages, the most
notable of which being orthogonality. Previously, maintaining for example
`Monad` and `Applicative` as unrelated classes would have required programmers
to provide implementations for both `pure` and `return`, despite the fact that
the two functions have equivalent semantics. Similarly, providing `Foldable`
and `Traversable` as part of separate libraries resulted many times in name
clashes between the standard `foldl` and the one in, say, `Data.Foldable`.

The major downside of this change is however that it makes Haskell completely
unsuitable for teaching functional programming in undergraduate courses. To
give just an example, the [Programming Paradigms][pp] course (held in Romanian)
at [UPB][cs-pub-ro], where I'm a teaching assistant, introduces functional
programming using Racket[^2], then focusing on Haskell to illustrate type
systems. By taking a look at the course's syllabus, the astute reader would
notice that type classes are the very last topic approached by the course.

This begs the question: how would the average teacher would thus use Haskell to
explain simple concepts such as folds on lists? and furthermore, how would
fundamental principles such as "types-as-documentation" be illustrated using
the mess of a signature that GHC 7.10 (and later versions, I presume) provides?
How is this even possible, when one of the first type signatures the student
ever reads begins with `:: Foldable t =>`?

To further twist the knife in this wound, it seems that trying to use standards
such as Haskell98 or Haskell2010 is now impossible. Previous versions of GHC
include a `haskell98` alternative to `base`, which makes it possible to run
GHCi the following way:

~~~~
$ ghci -hide-all-packages -package haskell98
~~~~

Searching through the mailing lists to find if I could make this possible in
the new GHC, I find out that the developers are planning to drop support for
the two standards altogether[^3], because "nobody uses them anyway". This is
the same kind of idiotic attitude that projects such as systemd are trying to
push, and while [they're winning][systemd] in the face of community
resignation, that doesn't make these changes any less outrageous.

Right now, Haskell teachers are left with very few alternatives:

* Putting political pressure on the GHC community to provide support for
  Haskell98/Haskell2010[^4],
* Reviving [Hugs][hugs], or
* Replacing Haskell itself with a purely functional language that is more
  oriented towards teaching[^5].

It's nothing but bitter irony that Haskell, a language praised by the
greats[^6], the language for which the term "[avoid success at all costs][spj]"
was coined, is now falling prey to its own popularity, thus becoming in a way
the C++ of functional languages[^7]. If that's the case, then sure, it's time
to move on.

[^1]: 7.10.2 at the time of writing.

[^2]: It's actually mostly Scheme, using Racket specifics where it's more
convenient to do so.

[^3]: [The future of the haskell2010/haskell98 packages - AKA Trac
#9590][haskell98-2010]

[^4]: Erik Meijer is one of the people who seem [to be doing
that][meijer-twitter], and he's [not the only one][lentczner].

[^5]: Miranda?

[^6]: Dijkstra himself wrote recommending the [replacement of Java with
Haskell][dijkstra] in introductory computer science courses. But "trends" seem
to be going [the opposite way][mit-python].

[^7]: This is not an evil in itself, it just shows that the language is mature
enough that it's starting to gather clutter, not unlike newer versions of C++.
The chief difference is that C++ is standardized, so that code written twenty
years ago still compiles. Regardless of this, both the existence of clutter and
the so-called "ossification" mean that the language starts losing relevance as
an instrument of research, and newer languages start becoming more interesting
in this respect. And programming language research is not doing particularly
badly at the moment.

[haskell-prelude]: https://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html
[famp]: https://wiki.haskell.org/Functor-Applicative-Monad_Proposal
[ftp]: https://wiki.haskell.org/Foldable_Traversable_In_Prelude
[pp]: http://elf.cs.pub.ro/pp/
[cs-pub-ro]: https://cs.pub.ro/
[haskell98-2010]: https://mail.haskell.org/pipermail/glasgow-haskell-users/2014-September/025280.html
[systemd]: /posts/y01/02b-how-and-why-systemd-has-won.html
[meijer-twitter]: https://twitter.com/headinthebox/status/652807907352911872
[lentczner]: https://mail.haskell.org/pipermail/ghc-devs/2015-October/010068.html
[hugs]: https://www.haskell.org/hugs/
[dijkstra]: https://www.cs.utexas.edu/~EWD/transcriptions/OtherDocs/Haskell.html
[spj]: https://www.youtube.com/watch?v=iSmkqocn0oQ&feature=share
[mit-python]: http://lambda-the-ultimate.org/node/3312
