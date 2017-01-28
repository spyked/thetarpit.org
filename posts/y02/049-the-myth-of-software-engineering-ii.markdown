---
postid: 049
title: Further on the myth of "software engineering"
date: May 14, 2016
author: Lucian Mogoșanu
tags: tech
---

"Software" sucks[^1].

This is a direct consequence of the fact that all physical systems
suck. Atoms suck, they can be split by nuclear fission. Molecules are
even more unreliable, as your average joe can destroy them via chemical
reactions. Living beings die of stuff which we don't even understand
properly: we all know why kidneys fail, why the heart fails, heck, even
something in the nature of cancer, but we're scarcely able to provide
strong solutions for these entirely *systemic* problems.

Agriculture sucks, as crops engineered to feed the masses are infested
by various little fuckers en masse.

All crafts suck. Even with sophisticated physical models, buildings will
most certainly fail because of structural degradation. Bridges have been
a bitch to build from Apollodorus of Damascus to date, and not much has
changed; spaceships fail more often than they work; your car will run
into a tree; heck, even your knife doesn't cut that bread the way you'd
like it to. In short, nature is imperfect, and man-made things even more
so, and to rub salt in the wound, it takes a shitload of work to make
all these imperfect things.

Despite the happy unicorns uttered by Western media, computers haven't
"gotten better" in time[^2]. Even if we were to take just the hardware,
in time it's gotten bigger in terms of design, more complex and more
esoteric, so if anything, modern computers suck a lot more than the
first ones made using integrated circuits[^3]. I won't even bother to
mention all those (micro)architectural "features" hardware vendors are
throwing at the market nowadays, each such feature marks another pain in
the proverbial[^4] ass.

And thus, all software sucks. [It's been said before][cat-v].

I'm not talking about the beautiful, platonic mathematical-logical
abstractions that some people call software. Those are indeed elegant
and sound and nice, but they are only so in theory[^5], that is, until
someone starts implementing them on a physical computing machine. And
that's not even counting non-deterministic phenomena such as random bit
flips, just take the inherently unsound hardware-software interface that
is the instruction set architecture and you have a set of basic
abstractions that are a hell to build software on.

Since all software sucks, the list of illustrations of how it does is
too ample to enumerate exhaustively, so we'll just limit ourselves to a
very few examples, a good one being the Unix-C duo that is still
haunting the world today. According to its author, Linux is a Unix
that's not even Unix, while C has spawned dozens of dialects, each one
more broken than the other, each one in its own way, in the name of
solving this-problem-or-the-other.

There have been futile attempts to make software not suck, the most
notable being the so-called "free software" movement started by Richard
Stallman in the '80s. The core principles of this movement are
ideological in nature, stating that people should have the freedom to do
whatever they like with their computers[^6]. From this thus follows that
people may take their software as it is and try to improve it in an
[unambiguously useful][myth-i] manner, that is, in a manner more related
to common sense than to the "cool factor". Why or how this didn't work
are entirely different stories, but the fact is that nowadays the GNU
people are consistently failing to adhere to their own principles.

On the other side of the ideological fence are the armies of "rockstar"
programmers fueled by childish enthusiasm and hired specifically to make
software suck. This can be grounded on the simple observation that
Microsoft's latest software, or Google's, or some startup's for that
matter, isn't getting any simpler. Quite the opposite in fact; any new
"feature" added in some product only serves, or has the side effect of
increasing "complexity", which in this case is another word for entropy.

Last but not least, software sucks harder than other engineering
disciplines because programmers "like to" write code, but very few
actually read it[^7]. This way, programming is done for the sake of
programming, not for the sake of making software suck less[^8], and for
the sake of adding more code instead of adding more simplicity, the
latter being after all the ultimate sophistication. The world is already
full of billions of lines of badly written source code, so why do we
need to write more? Ask yourself this question the next time you sit in
front of your text editor.

Quite simply put, we can only start discussing software engineering
after we stop just writing code and start trying to make software suck
less. This much all other engineering disciplines have figured out[^9].

[^1]: I wanted to make sure that this essay would get rejected from any
[respectable academic venue][academic-hogwash] out there, so I made the
abstract as abstract as possible, without however stripping it of its
essence. What do you mean, that's the definition of an abstract? It
doesn't even have any obscure technical words!

[^2]: Unless you take "better" in its nowadays' Newspeak meaning, so
"worse".

[^3]: One might be tempted to say that the vacuum tube ones made back in
the '40s were better due to the fact that they were simpler. Well,
actually not necessarily: the first ICs, way before the whole VLSI
craze, were far simpler and easier to maintain than the tube stuff. So
*that* was a huge step forward for computer engineering; today's
so-called advancements not that much.

[^4]: Literal too, given the time most computer people spend sitting on
their asses.

[^5]: Although the theory itself is rather flimsy, and I'm talking about
the fundamental theory of computing, not academic hogwash. Bear in mind
that Turing and Church's thesis is just that, a mere thesis. Also bear
in mind that via Gödel, the theory of computation has hard limitations
such as the halting problem, and since Turing few truly relevant
discoveries have been made in the field.

    So that's like, what? The last seven to eight decades? Not to
    mention that reasoning and proving facts about computer programs --
    or rather mathematical-logical models of computer programs -- simply
    doesn't scale unless you go down the abstraction rabbit hole.

[^6]: In hindsight, the man's ideas were way, way ahead of their time,
and many of them are still not properly understood by people claiming to
adhere to "Free Software". Claiming that "open source has taken over the
world" is very inaccurate, if not downright deceitful, given that a lot
of today's computers running "open source" are usable only if and how
some company or other lets them be usable. Not to mention the
[systemd][systemd] bullshit that's slowly permeating
[other projects too][ghc].

[^7]: In all honesty, because reading code is damn hard. But you know
what else is hard? Thinking. So go ahead and read the crap you or others
have written. Communication is a two-way lane, so learn to talk to your
computer already.

[^8]: In case you haven't been reading properly up until now, we oughta
be making software suck less, but not in terms of "code is
poetry". Sure, code readability is very important, but equally important
to making software actually work -- in the sense of reliability, not in
the retarded sense of "please restart your computer".

[^9]: Although some of the "computer science" idiocy is starting to seep
in there as well. Look at the internet of things, self-driving cars and
other products of [failed marketing][failure-marketing].

[academic-hogwash]: /posts/y02/045-academic-hogwash.html
[cat-v]: http://harmful.cat-v.org/software/
[systemd]: /posts/y01/02b-how-and-why-systemd-has-won.html
[ghc]: /posts/y02/03e-ghc-teaching.html
[myth-i]: /posts/y02/03c-the-myth-of-software-engineering.html
[failure-marketing]: /posts/y02/043-on-the-failure-of-marketing.html
