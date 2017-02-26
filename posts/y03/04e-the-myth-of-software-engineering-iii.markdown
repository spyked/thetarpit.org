---
postid: 04e
title: On system reliability, or, a top-down approach to (dispel the myth of) "software engineering"
date: August 18, 2016
author: Lucian Mogoșanu
tags: tech
---

After establishing that "software engineering" can only be considered an
honest engineering discipline through the practice of
[making software suck less][software-engineering-ii], the next logical
step is figuring out how to do that.

Software engineering methodologies are dime a dozen, and we might get to
them sometime later, but for now let us start from the system-level
view[^1].

As a tradition[^2] software engineers build their (general or
narrow-purpose) systems using the "commodity component-based"
philosophy, i.e. instead of rewriting software, they aim to reuse it as
much as possible. This approach may look sensible on the surface, except
when it isn't. In fact the mantra of "modularity" is nowadays flagrantly
overused in the field, as engineers either ignore or simply do not know
the trade-offs involved. The same is the case with software's so-called
"flexibility", which supposedly makes software cheaper to build than
hardware.

In this essay I will attempt to deconstruct this principle and its
supposedly magical properties by enumerating a set of trade-offs (or
problems, if you wish to call them such) that are particular to the
approach. The first two trade-offs stem from purely human issues.

**Trade-off 1: standards**. Engineers generally use standards to guide
  the building of their systems. In software this is rarely the
  case[^3], with many so-called "engineers" not even bothering to
  specify their software, let alone standardize it. Thus very often a
  single implementation of a program becomes the de facto standard, even
  in the free and open-source software world. I'm not even touching
  closed-source software with a ten foot pole here, that can of worms is
  too rotten.

**Trade-off 2: Abelson's saying**. Good software is in some sense not
  that different from good literature, e.g. well-known scientific
  papers. The latter are often partially or completely rewritten by
  multiple people, sometimes (more rarely) using multiple languages,
  thus giving the writer as well as the public a better idea of what the
  work says and does. On the other hand single designs and
  implementations are harbingers of mono-cultures, which lead to the
  narrowing of ideas[^4] in the field. Of course, sometimes new ideas
  are worse than no ideas.

The next two trade-offs are pure design considerations.

**Trade-off 3: dependencies**. The existence of granular components
  gives rise to (sometimes circular) dependencies, e.g. component D
  needs component C which relies on A and B to work. The number of
  implicit relations in dependency trees (or graphs) tend to grow
  exponentially, which makes solving dependencies a (generally) hard
  problem[^5].

**Trade-off 4: component versioning**. Components' interfaces change in
  time, which is especially problematic in the case of components with
  lax (or no) interface specification. This may give rise to situations
  such as (but not limited to) that in which D needs C needs A1 and B,
  while E needs A2 to work, where A1 and A2 are different versions of
  A. It may be that A1 and A2 cannot coexist in the system -- this is an
  addendum to trade-off 3, and it often makes engineering "commodity
  component-based" systems intractable, especially when so-called
  "software upgrades" are involved.

Finally, the fifth trade-off is of a mixed nature:

**Trade-off 5: fits-in-head**. Systems with a large number of components
  usually do not "fit in head", i.e. they are not fully understood by
  the engineers involved in developing it. This is another generally
  hard problem, the chief idea being that the bigger the number of
  components, the bigger is the number of unknowns. With this the
  probability of non-deterministic behaviour in the system grows and
  with it the system's overall fragility.

These trade-offs are far from being the only issues of the "commodity
component-based" approach and are not necessarily inherent to it. For
example the first two trade-offs are observable in other approaches too,
but bear more weight in the philosophical framework of code reuse.

As things usually go in any honest engineering discipline, one cannot
expect to find a magical solution to all these trade-offs, otherwise
they would be something other than trade-offs -- and the discipline
would yet again be something other than engineering. However, we can
derive a set of general principles to be used as rules of thumb, and
broken when absolutely necessary, as expected of engineering. These
principles can be formulated as follows:

**Principle 1: clarity of purpose**. Systems must be ideally designed
  with a single purpose in mind (or, to solve a single problem) and as a
  consequence must be as small as possible. The smaller its "number of
  purposes", the more resilient the system will be.

**Principle 2: integrated structure**. System designs must be
  monolithic. This does not preclude the use of components, as long as
  said components are fully integrated into the system[^6].

**Principle 3: convergence**. "Software upgrades" are to be
  avoided. Ideally the work will converge to a largely stable code
  base. Ading features or changing the system's scope should ideally
  result in a complete redesign and rewrite.

This list of rules of thumb is also necessarily incomplete, but we will
keep it short for the sake of enumerating a few principles rather than
rigid rules. More importantly, they may be taken as the first steps
toward an honest, sane, enthusiasm-free, minimal-suck approach to
software engineering.

[^1]: "Apps" are unimportant to the engineer, as "apps" usually suck by
    default. It is obvious that "apps" start from a (usually
    well-defined) purpose and evolve following
    [Philip Greenspun's tenth rule][tenth-rule], turning into monstrous
    gigantic pieces of crap that quite often *defeat* their original
    purpose.

    In other words, kids enthusiastically "code" "apps". Engineers
    design systems.

[^2]: As what is now a tradition, not as what was initially a
    tradition. Thinkers such as Knuth, [Dijkstra][dijkstra], etc. are
    very often utterly misunderstood.

[^3]: It used to be different with POSIX, ISO C, ANSI Common Lisp, etc.,
    but the bureaucrats simply couldn't keep up with the software
    enthusiasts. C'est la vie, as they say wherever they say that.

[^4]: This was for example discussed in the essay on
    [operating system design][os-design]. POSIX being a standard was in
    itself a trade-off, as it ended up being used by most
    production-grade systems, but in the process it effectively killed
    operating systems research. Also see Pike,
    [Systems Software Research is Irrelevant][systems-software].

[^5]: Which in turn leads to so-called "dependency hells". See Haskell's
    Cabal dependency hell for more details. Moreover, the current
    solution, the Haskell Tool Stack, is not an elegant one to say the
    least; more like a palliative, I would say.

[^6]: The Linux kernel is a good example of a system* that is monolithic
    yet modular -- monolithic in the sense that every piece of code may
    (roughly) access any data object in the kernel; modular in the sense
    that functionality is (roughly) split across compilation units.

    These are not the only two ways to look at Linux as
    modular/monolithic -- for example run-time device probing makes the
    kernel modular**, while the system designer's ability to statically
    choose what components are included, and enforce that state of
    affairs at run-time, makes it monolithic --, but they nevertheless
    constitute two possible ways.
    
    \-\-\-  
    * Although not a system by itself.  
    ** And, as by-product, portable.

[software-engineering-ii]: /posts/y02/049-the-myth-of-software-engineering-ii.html
[tenth-rule]: http://c2.com/cgi/wiki?GreenspunsTenthRuleOfProgramming
[dijkstra]: https://www.cs.utexas.edu/users/EWD/transcriptions/EWD10xx/EWD1036.html
[os-design]: /posts/y01/03a-the-linguistic-barrier-of-os-design.html
[systems-software]: http://herpolhode.com/rob/utah2000.pdf
