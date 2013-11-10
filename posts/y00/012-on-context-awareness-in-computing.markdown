---
postid: 012
title: On context awareness in computing
excerpt: An analogy between natural language and computing.
author: Lucian Mogoșanu
date: November 10, 2013
tags: cogitatio, tech
---

The term "context awareness" relates mainly to linguistics, i.e. the quality of
a language of being context-(in)dependent, although it can be described in more
generic terms.

For example, let $S$ be a topological structure. We don't much care about how
the structure looks; it could be a free monoid; since I'm into category theory,
it might as well be a category $\mathcal{C}$ with objects and arrows; maybe
you're more into physics, so it could be a phase space or a probability space;
whatever.

## Context awareness, context dependence

If we define a "location" as an arbitrary point $p \in S$, then the "context"
of $p$ is its [neighbourhood][1]. We need not think of the particulars of the
neighbourhood, since, as we said, we don't really care about the particulars of
$S$. This context we speak of must therefore, in addition to its mathematical
meaning, have some use to us, which, as far as I can tell, is obvious: if we
set $p$ as a reference point (like, for example, we set an origin in a
Cartesian system), then we can describe its neighborhood in respect, or
relative, to $p$, rather than devising an absolute description using $S$. While
this approach might not give us any advantages from a mathematical point of
view, it certainly has practical advantages.

For example, let's say I'm in a house that has two rooms, $r_0$ and $r_1$. Each
room has a bag of pretzels, and since I'm, let's say, in $r_0$, I'm eating
pretzels from the bag in that particular room. At some point in time, I say to
you, the reader, also situated in $r_0$, that "these pretzels are making me
thirsty". To understand my utterance, your mind automagically comes with the
following model.

Since there are two rooms in the house, its simplest abstraction is the set $R
= \{r_0, r_1\}$. Also, since there is a flow of time in our universe, there
exists a set $T$ expressing time. Also, since you are paying attention to
someone at some point, you can come up with a set $P$ of people. We shall
denote with $\Pi$ the cartesian product of the aforementioned sets, thus $\Pi =
R \times T \times P$. Note that this is only enough to describe the context,
not the entire "space of action".

At one point $\pi \in \Pi$ I tell you that "these pretzels are making me
thirsty". Now, since you're using $\pi$ as a reference, you can infer that I am
referring to the pretzels in $r_0$, rather than the ones in the neighbouring
room. This is essential to human interaction, since it relieves us of the
burden of explaining *the entire* context, by using it as an implicit
construct[^1]. Thus humans are context-aware machines, and it would be
impossible for a human society to exist without the individuals' ability to
generate and comprehend context-dependent language. ▪

Thus we define "context awareness" as the ability to be intrinsically aware of
context, context dependence and/or anything equivalent to that.

## Context awareness in computing

Context awareness is given a lot of attention in the context of (semantic or
otherwise) web applications. For example, Google is aware of your location when
it suggests a particular restaurant, and of the time of day and day of week
when it tells you the fastest route to work; Facebook displays context-aware
suggestions and posts depending on the things you liked at a given point in
time; and so on. This is, however, sugar, or icing on the cake, call it
whatever you like. There are more fundamental uses of context awareness.

The [GHC][2] Haskell interpreter is one such example. While Haskell is a purely
functional language, and by default models stateless programs, monads can serve
as a vehicle for state, and GHCi uses the `Prelude` monad to do its stuff. For
example we can write:

~~~~ {.haskell}
Prelude> take 10 $ iterate id "bla"
["bla","bla","bla","bla","bla","bla","bla","bla","bla","bla"]
~~~~

which is an arbitrary Haskell expression. The `Prelude` monad allows us to use
the previous result in the current computation, via `it`:

~~~~ {.haskell}
Prelude> take 2 $ map (++ " foo") it
["bla foo","bla foo"]
~~~~

Another, more notable, example, is the language Perl, which has a special
variable, `$_`, defined implicitly in some contexts such as loops. Let's take
the following example[^2]:

~~~~ {.perl}
#!/usr/bin/env perl
use v5.10;
while(<>) {
	next if /^#/;
	last if /^q(?:uit)?$/;
	say "Howdy!" if /^hello$/;
}
~~~~

What the Perl program does is, it implicitly defines `$_` as the result of `<>`
and verifies it against three particular patterns at every iteration. This
should come as a natural thing to anyone who speaks a language, as the `$_`
variable is tied to the `while (<>)` context, and it's only natural to use it
as an implicit comparator (that is, without even mentioning it) in that
specific context[^3]. This pearl is structurally identical to our pretzels
example and GHCi's `it`, which, by the way, isn't called `it` arbitrarily,
since we use it (sic) abundantly in everyday communication.

What bothers me, however, is that this approach isn't used more in computing.
`ping` for example is dumb enough to not infer the current network address
whenever I type something like:

~~~~ {.bash}
$ ping .7
~~~~

The full address would, of course, be something along the lines of
`192.168.1.7`, but I'm already part of the `192.168.1.0/24` network, otherwise
I wouldn't be able to communicate with `.7`. Sure, an argument against context
awareness would be that I could be part of other networks too, say,
`10.0.0.0/16`, but ping could simply select the first available device and let
the user specify it explicitly if required[^4] [^5]. Well, at least IPv6
addresses have shortened forms.

Before I end the post, I feel compelled to mention that context awareness also
has a big disadvantage, and that is the increased probability of ambiguity,
which is especially damaging to artificial/formal languages. Languages such as
Perl solve this issue by introducing a "canonical form" and additional
constraints, such as binding `it`/`$_` to the innermost context.

In natural language, on the other hand, beating a horse to death has a
different meaning depending on whether you're a gymnast or a cowboy.

[^1]: We both know we're in a house with two rooms, in $r_0$ at some point in
time, we are paying attention to each other and there are pretzels. Lots of
tasty and incredibly salty pretzels.

[^2]: Shamelessly stolen from [Stack Overflow][3].

[^3]: That's what you get for using a language designed by a linguist.

[^4]: According to the [manual page][4], by passing the `-I` flag.

[^5]: This covers most use cases. 2013 or not, I'm not using fancy stuff such
as multipath TCP, so I have only one active net interface most of the times. I
bet the same holds true for most amateur ping users, maybe even for some
sysadmins.

[1]: https://en.wikipedia.org/wiki/Neighbourhood_(mathematics)
[2]: http://www.haskell.org/ghc/docs/7.6.1/html/users_guide/ghci.html#ghci-introduction
[3]: http://stackoverflow.com/questions/3589837/what-is-the-significance-of-an-underscore-in-perl
[4]: http://linuxcommand.org/man_pages/ping8.html
