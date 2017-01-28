---
postid: 052
title: On the unambiguous usefulness of tools (in software and elsewhere)
date: November 5, 2016
author: Lucian Mogoșanu
tags: tech
---

In [one of my previous essays][software-engineering] I mentioned this
rare property of software, of being "unambiguously useful".

This property applies -- or it very often doesn't -- to all things. For
example hammers are unambiguously useful, as they can be *used for*
driving nails into stuff. Phones are unambiguously useful because they
can be *used for* talking over long distances. And so forth.

Tools on the other hand may be used in contexts where they are clearly
not useful, or where their usefulness is otherwise unclear. For example
it doesn't really make sense to drive an automobile in overcrowded towns
where the traffic is high, where walking could be at least as
efficient. Computers by themselves are for example not useful in any
unambiguous way: they may be used for one purpose or another depending
on their performance and/or the software they have installed, but they
may also be used for completely irrational, anti-economical purposes, as
the [market-driven monkeys][google-stupid] often do.

In computing the "tool-based approach" can sometimes be a particularly
harmful beast[^1]. Nevermind that CAD[^2] tools haven't helped bring
anything new to fields such as, say, architecture. The number of tools
available to solve (often general-purpose) problems in computers has
exploded, often without any real positive impact on the fields they're
used in[^3]. This would not be by itself a problem if it weren't for
those naïve wielders who think that the tool will solve all their
problems, and who come to rely on the tool more than on the funny thing
between their shoulders. But given this context, we can indeed say that
tools may be not merely unproductive, but also counterproductive; and
not merely useless, but also harmful.

So now that we know for sure that this ambiguity of usefulness is
prevalent throughout the various areas of technology, we can fortunately
draw from the examples above to define more precisely what it means for
a tool to be "unambiguously useful". I happen to think that the
following is a very good criterion for judging the usefulness of tools,
in software and in general:

**Tools are unambiguously useful if and only if they are used to replace
human labour, and not the human mind.**

For example a pocket calculator is unambiguously useful because it can
do all that basic arithmetics faster and less error prone than you; it's
however not meant to replace your knowledge of basic
arithmetics. Compilers and interpreters are useful because they can
automatically translate programs from a convenient[^4] level of
abstraction to machine code. Operating systems[^5] provide users with a
minimal set of tools to help the user automate tasks that would normally
take a lot of time to perform.

As a counter-example, tools that aim to automatically find bugs in
computer software are usually not unambiguously useful, although they
might seem to be. While they may be successful at their task, they may
also encourage their users to express intellectual laziness by yielding
only dry results, without any improvement in the understanding of the
root cause of said bugs[^6]. The same can be said about automated spell
checkers in the hands of the functionally illiterate.

So in general tools are unambiguously useful if they help you do the
same stupid[^7] shit you normally do, but with significantly less
effort.

[^1]: Or, as ol' Dijkstra would say, "tool-based software(-based)
    engineering considered harmful".

[^2]: Computer-assisted, or Computer-aided Design.

[^3]: Take programming languages for example. We nowadays have languages
    (Coq, Isabelle/HOL, Agda, etc.) that allow programmers to
    mechanically verify the correctness of their implementations with
    respect to some specification. How many programs do you know that
    are even partially implemented this way? I can name a few, but only
    a very few.

    Take Integrated Development Environments (IDEs) as another
    example. There is no doubt about the fact that they often come with
    very useful features, but is there any qualitative measure of their
    help in improving software? I'll leave this thought experiment to
    the reader.

[^4]: Although "convenient" is definitely *not* an unambiguous
    description. Going too high or too low up or down the abstraction
    ladder can be a bullet in the foot,
    [depending on][software-engineering-iii] what you're implementing.

[^5]: By which I mean professional operating systems, not Windows, or
    whatever people use nowadays for gaming.

    Y'know, the ones with the nasty command-line shells and whatnot.

[^6]: This is inherent in the definition of "computer bugs". Analysis
    tools may detect simple bugs such as buffer overflows, but they will
    never be able to help the programmer to properly code buffer
    overflow-free software in the future, while buffer overflows are the
    main cause of some of the nasty security bugs in the 2010s.

    Meanwhile there are classes of bugs, such as semantic bugs, that can
    only be detected through thorough testing or other methods such as
    formal verification. In short, they demand intellectual resources
    and huge chunks of attention, which are the scarcest things out
    there. Ain't nobody got time fo' that, unfortunately.

[^7]: Do not, I repeat, do *not* dismiss this as mere claptrap. If
    anything, the goal of artificial intelligence is of a purely
    philosophical nature. With all the fancy AI algorithms, we still
    don't understand precisely why some of the tasks that seem so simple
    to us are mind-blowingly hard to program into a computer.

    AI and "cognitive science" will advance beyond snake oil by finding
    the answers to such questions, not by turning people into
    [statistical models][google-stupid]. But I repeat myself.

[software-engineering]: /posts/y02/03c-the-myth-of-software-engineering.html
[google-stupid]: /posts/y02/046-google-is-making-you-stupid.html
[software-engineering-iii]: /posts/y03/04e-the-myth-of-software-engineering-iii.html
