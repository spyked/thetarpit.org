---
postid: 05e
title: The generative model of computing
date: April 2, 2017
author: Lucian Mogoșanu
tags: asphalt, tech
---

*Once upon a time I [wrote a piece][modelul-generativ] that turned out
decent enough to deserve being re-written in English. This is the result
of that re-write.*

One of the fundamental properties of computing is that it can be
represented at various layers of abstraction: what constitues a program?
Is it made up from a bunch of electrical signals? Or from evolving bits?
Is it a set of registers changing their values in time? Or variables
that are read, written and executed? Any of these is a valid
representation, only one of them may be more useful to us than the
others at a given time.

At the same time, one of the fundamental problems of software is that it
is inherently replicable. Mind you, this is not *my* problem; I myself
am very happy with how computing and software work -- at least when they
do[^1] -- which makes this ease of replication the exact opposite of a
problem. It is however a problem for halfwits; for those people who
believe that something that was read, and thus learned, can and
sometimes must be magically un-learned; or who believe that something
that was uttered can be magically un-uttered. No one sane knows why
anyone would ever wish for this piece of nonsense to be possible[^2],
but computer engineering is supposed to give practical solutions to
technical problems, and I'm feeling particularly generous today, so
let's indulge this intellectual wankery.

As I was saying, software is replicable, and the problem is whether it
can be made impossible, or at the very least extremely hard to
replicate. That is, it is easy for virtually anyone to download a
program off the Internet and run it on their computers; or a movie, or a
secret document, and open them using a program. This works even when one
is not legally authorized to do so, and it's simpler and a lot cheaper
than actually stealing things, which forces the *actual* economic value
of intellectual property to asymptotically go towards zero.

This pernicious issue can be easily described at the instruction set
architecture level. Generally processors contain an instruction dubbed
`mov`, which moves a numeric value from a register to another. The
problem, however, is precisely that it *doesn't* move data: it copies
it! That is, when saying `mov r0, r1`, we read for example "move data
from `r1` to `r0`", but we mean "copy data from `r1` to `r0`"; in other
words, upon setting `r0` to the contents in `r1`, `r1`'s value doesn't
change at all[^3]. This is so for very good practical reasons: firstly,
it is more expensive to actually move data from one register to another,
as we need to do two operations (set destination to source value; then
erase source) instead of one; secondly, we don't know what the value of
an "erased" (or otherwise "empty") register should be.

But let's leave aside these details for a moment and specify in more
precise terms what it is that we want: a computer that cannot *copy*
data per se, and that can only *move* it. This is, of course,
impossible: one must *put*, i.e. create, or otherwise generate an
object somewhere in able to be able to then move it somewhere else. So
what we really want is a computer with two basic operations:

* a `move` operation: from register to register, from main memory to
  register, from disk to main memory, etc.
* a `generate` operation, that "puts" data into a memory unit (register,
  a cell in main memory, on disk, etc.)

An intuitive way to look at this is that any memory unit can be in one
of two states: either "empty", in which case it cannot be read
(i.e. used as a source); or "full", in which case it could be used as a
source or destination if the user desires. Thus `move` cannot read from
an empty register, while `generate` is pretty much equivalent to our old
`mov`: it can read and write from and to anything. The advantage of this
separation is that it would allow hardware manufacturers to limit the
use of `generate`, by imposing a price on every instruction call and/or
other policies, possibly used in conjunction with cryptographic
approaches. Simply put, the possibility of having an instruction set
with a `move` and a restricted `generate` opens up the possibility of a
whole new different type of computing.

Let's look at some of the practical design and implementation challenges
of this model. Performance is an issue, as discussed previously, at
least as far as the fabrication technology remains the same. Space is
also an issue, as every memory cell now needs at least an extra bit to
represent empty or full state. Since the data in memory cells is usually
moved around, then a. all `move` instructions need to be transactions,
i.e. if and when a `move` is completed, we are guaranteed that the
destination contains the desired data and the source is empty, otherwise
the `move` has failed and the state hasn't changed; and b. all memory
must be persistent, such that e.g. following a power outage the system
can be restored to its previous state without any data loss. These
engineering problems are perfectly approachable, if not necessarily
trivial.

Then there are deeper problems: is this type of computer
Turing-complete? This question cannot be given an off-the-top-of-head
answer, and shall not be explored here due to space constraints.

Then there are other practical problems: how easy is it to program such
a computer? Adding costs to copying would conceivably put a limit on the
development of software, as it would emphasize economy over the writing
of code; but that aside, how usable would the machine be from the point
of view of the user/programmer[^4]?

Then there is the problem that software producers themselves would need
need to pay for every software copy that they sell, because they would
need to copy it before selling it. Which brings us to the crux of the
problem: software and hardware vendors concoct all these technologies,
e.g. SGX, various DRM "solutions", without thinking of many of the
trade-offs involved. One can't stop copying without putting limits to
it; and then once they've done this, they can't copy without actually
copying[^5]; no, you can't have your cake and eat it too.

[^1]: See "[The myth of software engineering][software-engineering]".

[^2]: Oh, yes, I do very well, thank you. But this doesn't make you any
    less of an idiot.

[^3]: This also holds true for other operations, e.g. the arithmetic and
    logic ones. For example `add r0, r1` typically adds the value in
    `r1` to that in `r0` and stores it in `r0`, but leaves `r1` intact,
    and so on.

[^4]: To be perfectly clear: I can write code in assembly as easily as I
    can write it in Python or almost any other language you'll give me,
    because I practice these kinds of things and I can easily determine
    the strengths of each particular language. However, I cannot as
    easily program a quantum computer, because I don't know how to, and
    because much of the knowledge of how to generally do it hasn't been
    discovered yet. Sure, we know what the basic primitives are and
    quite a few algorithms are well-specified, but let's say I wanted to
    make my own Nethack implementation on a Quantum machine.

    Contrary to what you might think, Nethack is an important cultural
    product of this era, so why would not this be a legitimate question?

[^5]: Take the DRM technologies used for video streaming for example:
    they've come so far as to keep the DRM code and decryption keys
    secret in a processor mode that is controlled by the manufacturer --
    which assumes *implicit* trust on the user's part, which is stupid,
    that is to say, a socialist measure, which is to say, entirely
    tyrannical yet pretending to be something else -- but the data still
    needs to reach your display decrypted, so that useful data, and not
    garbage, is displayed. And even if the decryption algorithm and keys
    were embedded in the display, you could still film what the display
    is showing, which makes the whole charade pointless.

    In other words, they are implementing a solution which *provably*
    doesn't work, and by the by, they are also running secret software
    on your computing device. Secret software which, of course, could
    not possibly spy on you or impersonate you in ways you haven't even
    imagined. But using PGP is bad and, y'know, generally a terrorist
    thing to do.

[modelul-generativ]: http://lucian.mogosanu.ro/bricks/modelul-generativ-al-software-ului
[software-engineering]: /posts/y02/03c-the-myth-of-software-engineering.html
