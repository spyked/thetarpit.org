---
postid: 022
title: Bitcoin as infrastructure [ii]
date: June 1, 2014
author: Lucian Mogoșanu
tags: cogitatio, tech
---

Also read: [Part I][1].

## Part II: The fractal nature of computing infrastructure

In the previous part of my essay I argued and described the importance of
"networks" in the structure and organization of natural things, and, naturally,
in human society, illustrating it with historical examples. A crucial stepping
stone towards the Bitcoin-as-infrastructure was and is the computing machine,
which is why I will rest upon it for a moment, also partly because it has been
one of my main areas of study for the past seven years or so.

I am afraid (and I hope that I am wrong in this regard) that many of the people
sitting in front of their computers reading this text don't consider the deep
meaning and implication of what I call "computing machines". To be entirely
honest, even the more enlightened scientists, engineers and philosophers are
quite baffled by the concept: computers are machines that "do stuff", "on their
own", and we only manage to communicate with them properly in the universal
language of mathematics[^3]. Amusingly, most probably computer scientists won't
hate me (too much) for providing such a vague definition, mostly because they
aren't able to provide a (much) better definition themselves[^4], and I know
that because I call myself a computer scientist.

The breakthrough in computing sciences was set by a few theoretical models, of
which I will remind the Turing Machine devised by Alan Turing, the Lambda
Calculus conceived by Alonzo Church (Turing's doctoral advisor), the Markov
algorithmic machine named after Andrey Markov and, last but not least, the
First-Order Predicate Calculus. These all describe "Turing-equivalent"
machines, upon which mathematicians and engineers, the most notable being Jon
von Neumann, laid the foundation for the first electrical computers, about one
century after Babbage's mechanical Difference Engine.

In essence, electrical computers are based upon electrical circuits, which are
nothing more than networks through which electrical signals propagate. To
encode and process useful information, said circuits use binary voltage
differences and amplifiers, translated conceptually into boolean logic gates.
Of course, things are a bit more complicated, since signals propagate in time
with the use of a clock, which paves the way for sequential circuits. Thus,
essentially, processing units are sequential circuits which read instructions
from a memory and, based on their encoding, generate some side effect into a
memory -- the same or another, this is not relevant for the definition.

From vacuum tubes to transistors and then to integrated circuits, from ENIAC to
the smartphone in your pocket, all computers are based on the same principle.
Nothing much has changed from mid 20th century to the present day in terms of
theoretical achievements[^5], all hardware improvements being purely of
technological nature. Qualitative improvements arised, however, firstly in
terms of computing scalability and secondly in terms of software
sophistication.

"The fractal nature of computing infrastructure" might sound like a rather
pompous formulation. I'm not going to argue, it probably is, but it's also
true: computers, networks by nature, have evolved into networks-of-networks as
computer networks arised, this evolution giving birth first to local networks,
which then extended to a global network which we now know as the Internet. It's
important to understand that the consolidation of our current networking
infrastructure required little in terms of scientific innovation, as they were
formed naturally as the number of computers in the world grew. And as the
telegraph was tied to railroads in the 1800s, so the Internet was tied to
telephone lines at the end of the 1990s, until the infrastructure was updated
to optical fiber. And then the Internet itself, barely understood by anyone,
gave way to chaos by becoming infrastructure for some of the software
projects.

One of these projects is the hypertext developed by Tim Berners-Lee sometime
around 1990 at CERN. This in turn evolved into the Web, which itself is a
network within a network and an infrastructure for content and applications.
Now, if we stop for a moment to reflect upon this fractal nature of computers,
we notice that it emerges from the property of Turing machines to run other
Turing machines, facilitating the stacking of layers upon layers of
complexity[^6].

You are probably aware of the rest of the story: search engines, blogs, social
networks, the Cloud, all of them fascinating products of the age of the
Internet. While this comprises no more than about fifteen years of history,
it's way too much to fit here. Besides, some of these things will pass, some
will live on, while some will be remembered in the future; which brings me to
the next part of my essay.

**Next**: [Bitcoin as infrastructure][2]

[^3]: Those which you call "programming languages" could as well be considered
a morphologically and syntactically altered subset of mathematics.

[^4]: Unlike, for example, electrical engineers, who would stab me to death if
I defined the capacitor as a "bucket of electrons with a small hole in it". And
here we come to one of the fundamental problems of computer science, that of
providing precise definitions to otherwise confusing concepts. To paraphrase
Phil Karlton, "There are two hard things in computer science: cache
invalidation, naming things and off-by-one errors".

[^5]: If we rule out quantum computers, which are still a subject of research.

[^6]: It is, after all, turtles all the way down.

[1]: /posts/y00/01f-bitcoin-as-infrastructure-i.html
[2]: /posts/y01/027-bitcoin-as-infrastructure-iii.html
