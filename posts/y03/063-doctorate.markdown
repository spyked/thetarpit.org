---
postid: 063
title: The doctorate as a (journey through a) tar pit
date: June 11, 2017
author: Lucian Mogoșanu
tags: in the flesh
---

The blog you are reading has been on a hiatus (sort of) for the last
month and will thus be for about one more month if not three. In case
the reader is wondering -- a fact that I very much doubt -- there is a
backlog of vitriol and wit (and the other way around) waiting to be
published, and I'm eager to get back to the pleasant yet burdensome job
of reviewing and (re)writing. But alas, at the moment I am pouring my
energy into other writing work, a work which also constitues the subject
of this rare occurence of a tarpitian weblog-as-a-journal entry -- an
approach to writing which, by the way, I don't intend to attempt again
in the near future.

Anyway, in 2013 -- about two months after starting this blog, to be more
precise -- I started a doctorate. Four years later it's almost done, the
thesis is abandoned and therefore ready to be laid out before the public
eye and a PhD committee; it will also soon be ready to be jumped through
some bureaucratic hoops that don't matter. At the end, big whoop, people
who don't know better will be able to officially call me a "PhD", which
also doesn't matter. What matters is a. what the hell did I waste four
years of my life on, and b. what has this left me with at the end.

I have been wasting the last four years -- you don't like it when I say
"wasting", although you suspect there's some truth to it, right? Right?
Okay, let me put this in mellower terms: I have invested four years of
my life in a tar pit, a journey composed of two parts.

The first part of this journey consisted in studying software that is
formally verified [at huge costs][reversing-lists] and which doesn't
really fit in head. Fortunately I was also working on some practical
problems at a time, which didn't give me any time for what Heiser calls
proof engineering, which actually left us[^1] looking for more
down-to-earth solutions. This led us to try retrofitting a run-time
verification method called property-based testing[^2] for the purpose of
testing low-level stateful programs, which resulted in a paper[^3] which
will actually be extended in the thesis, which will hopefully make it
more decent.

To reiterate: I spent my first two PhD years searching for practical
methods of finding bugs in software systems. The results are pretty
elegant: based on a very simple partial API spec, we were able to find
bugs in various components of a microkernel-based system. However, as a
wise man once said, [totul în viață se plătește][freedom-slavery], which
is how property-based testing requires actual human intervention in
order to work. Curiously enough, this method has been used for decades
in testing hardware, I don't know why Claessen and Hughes had to write a
Haskell tool in order to make it obvious that it also works for
software.

The second part of my journey/tar pit started as an internship at
[DSLAB][dslab], working with a few really smart people on mitigations
for memory bugs for, you guessed right, systems software -- the reader
will notice how this seems to become a recurring theme of my work; and
the reader is right. I started out trying and partially succeeding in
enforcing some partial memory safety properties for an operating system
kernel like any other, and by 2016 (that is, about one year since I had
met the DLSAB team) this had branched out into at least two other
projects which required non-trivial amounts of work to get done -- and
frankly, they're still not done.

I'm not going to go into too many details, but we've learned that with
some software and/or hardware modifications it's pretty easy to then
automatically enforce memory safety properties using compiler techniques
as aid -- there is a ton of previous work we had to compare with, I'll
leave the gory details for the thesis. I also found out that I am
completely at odds with the automatic program transformation/enforcement
philosophy[^4], which marks the end of my work in these kinds of
research problems[^5]. Still, there is some satisfaction and the
potential for genuinely new ideas in exploring the field, so I wouldn't
particularly discourage any brave soul from diving into it.

To sum up, I spent the last four years exploring a couple of technical
means of improving systems security. The extent to which my work has
actually improved security will be left as exercise to those who will
have read my thesis. I don't believe in my ideas anymore than anyone
could believe in the laws of gravity -- they're there, and whether they
will be of any practical use remains to be seen.

Still, I've learned a bunch of important things during this tar pit,
some of which have seeped into this blog. I learned to read papers and
criticize them and I learned that writing seriously requires time,
patience and an eye for detail. I relearned that
[causes matter, purposes don't][cauze-si-scopuri] and that the elderly
that has passed the test of time is infinitely more valuable than the
sexy new; also, that it's easy to publish papers with no scientific
value, that is, crap. I learned that security is by and large
[a cultural construct][on-security], which constitutes the chief
intuition that got me into teaching. I also learned that reading
code[^6] and understanding systems is far more important than "coding"
and that reliable systems survive despite attempts to democracy, not
because of them. Each of these aspects has the potential to make a
separate essay at the right time.

In conclusion, I went through a doctorate and now I have a thesis to
write. Not the worst way to spend one's time, so see you later.

"But Lucian, wait! If you could go back in time and choose, would you do
this again?" Really, what kind of ludicrous question is this?

[^1]: Yes, the academic "we".

[^2]: Claessen, K., & Hughes, J. (2011). QuickCheck: a lightweight tool
    for random testing of Haskell programs. *ACM SIGPLAN notices*, 46(4),
    53-64.

[^3]: Dragomir, C., Mogosanu, L., Carabas, M., Deaconescu, R., & Tapus,
    N. (2015). Towards the Property-Based Testing of an L4 Microkernel
    API. In VECoS (pp. 39-50).

[^4]: The discussion of why automatic property enforcement is
    practically speaking a pretty dubious philosophy is long and has
    many layers of argumentation, but this is as good a place as any to
    have it. So let's peel the onion.

    The first layer of doubtfulness is that property enforcement solves
    the problems of stupid people and nobody else. The reason
    e.g. memory bugs appear in programs is not that "languages are
    unsafe", but that programmers don't know how to code properly, and
    this is not only a technical problem, it's
    [an ideological one][software-engineering-ii]. What's worse is that
    said method doesn't make programmers code any better -- if anything,
    it may make them code worse by instilling a potentially unwarranted
    sense of security.

    The second layer is a restatement of
    [the problem of trust][problem-of-trust]: the way program
    enforcement works is by adding program transformation tools to the
    system. But do we just trust that those tools work? Do we instead
    recursively apply the algorithm of adding more tools? This of course
    is untenable from the point of view of complexity, which is why the
    ultimate trustee is the human mind, which, unlike *every* or *any*
    algorithm out there, is capable of understanding. Which
    philosophically makes the entire approach questionable: if the human
    mind was the only tenable approach all along, then why invest in
    additional tooling?  Do note that I am not dismissing tooling
    entirely, but putting it under scrutiny -- is tool T
    [unambiguously useful][unambiguous]?

    The third layer is a drive of the modern engineer of trying to solve
    all the possible issues. There are languages that do memory safety
    already, but, naturally, they don't do it fast enough; or: we could
    add hardware support for memory safety, but then it would break
    compatibility with existing systems; or: it's fast and compatible,
    but then there's the political issue that random corporation just
    doesn't want it, because they've got their own agenda. More simply
    put, there may be some research in building a design from first
    principles, but most people won't do it for stupid reasons. They
    don't realize that overoptimization will ultimately reduce them to
    cripples, but who am I to disagree with them. I did say and I will
    repeat it: *totul* în viață se plătește.

    The fourth layer is a restatement of the third, but in the past: all
    the memory safe systems have already been built about thirty to
    fifty years ago. Lisp machines were a thing long before I was born
    and all I'm doing is reinventing the wheel in the most stupid way
    possible. Oh, yes, but it works on Intel CPUs, and the fact that
    this matters for Intel and other purely politically driven entities
    is supposed to make me feel better.

    As a conclusion to this footnote -- which could have been a post on
    its own, but it's not because I like pissing people off with my long
    footnotes -- see the next footnote.

[^5]: Also, if I ever work on any kind of research problems in the
    future, it will most probably -- and sadly -- not be as part of
    academic institutions. [Sorry for your loss][academic-hogwash].

[^6]: That is, specifications made for humans to understand and only
    incidentally for machines to execute. You see, Abelson and Sussman
    are part of that now gone generation of engineers who didn't code
    for fun, but actually intended to make things (that) work.

[reversing-lists]: /posts/y03/057-reversing-lists.html
[freedom-slavery]: /posts/y03/04f-freedom-is-slavery.html
[dslab]: http://dslab.epfl.ch/
[academic-hogwash]: /posts/y02/045-academic-hogwash.html
[software-engineering-ii]: /posts/y02/049-the-myth-of-software-engineering-ii.html
[problem-of-trust]: /posts/y03/059-the-problem-of-trust.html
[unambiguous]: /posts/y03/052-on-the-unambiguous-usefulness-of-tools.html
[cauze-si-scopuri]: http://trilema.com/2009/cauze-si-scopuri/
[on-security]: /posts/y02/04a-on-security.html
