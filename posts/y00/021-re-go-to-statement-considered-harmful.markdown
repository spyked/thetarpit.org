---
postid: 021
title: Re: Go-to statement considered harmful
excerpt: Yet another rant on the difficulty of the discipline of programming.
date: May 24, 2014
author: Lucian Mogoșanu
tags: tech
---

The late Edsger Dijkstra, indeed one of the greats in this rather odd field of
Computer Science[^1], at the end of the 1960s wrote a letter (or short essay,
if you will) called "Go-to statement considered harmful", published in the 11th
volume of the Communications of the ACM. Now, remember that those were dark
times, before Java, Haskell or Scala, and before even C became popular as a
programming language. Said letter might have even had some influence on the
design of these languages, who knows.

About forty-five years later, give or take a few, the case against "goto"s
still stands, given that C isn't dead. As a matter of fact it's thriving as
a systems language a-bit-above-assembly and we don't see it going away too
soon. That doesn't mean programmers use "goto" statements as often as they did
in the aforementioned dark times, when BASIC ruled the world (or did it?), but
they often do, and when they do, chaos ensues (or does it?).

I will in this essay play the devil's advocate. Having said that, if you're not
proficient in at least three or four programming languages, then I urge you to
go and read [SICP][1] or another introductive Computer Science writing.
Otherwise, proceed to read Dijkstra's essay[^2] and return here afterwards.

My first issue with Dijkstra's reasoning lies in one of his assumptions,
namely, and I quote:

> My second remark is that our intellectual powers are rather geared to master
> static relations and that our powers to visualize processes evolving in time
> are relatively poorly developed. For that reason we should do (as wise
> programmers aware of our limitations) our utmost to shorten the conceptual
> gap between the static program and the dynamic process, to make the
> correspondence between the program (spread out in text space) and the process
> (spread out in time) as trivial as possible.

The first sentence is indeed true: humans generally find it hard to grasp
processes, be they of mathematical, algorithmical or some other description. We
reason poorly when it comes to temporal phenomena, despite the (seemingly
paradoxical) fact that we are well suited to handle them unconsciously or
subconsciously, or develop some feedback-based mechanism to approximate a
solution[^3].

I don't agree with the remainder of the paragraph, though, due to the fact that
it implies (or it doesn't and I'm getting it all wrong) that we should strive
to make programming languages more "comfy", and once we do that, it's all going
to be nice and dandy and "structured programming" is going to solve all our
problems. There are at least a million examples which can invalidate this line
of reasoning.

The fact is, we can't make programming more "comfortable", no matter how we put
it, and Edsger seems to have [figured that out][4] way before I did it, that's
for sure.

Look at procedural programming for example: C is one of the most "comfortable"
programming languages there are, given that you know how electronic computing
machines work, and yet most undergrads have great difficulty in understanding
how pointers work, not to mention dynamic memory allocation and other such
techniques which are crucial to a programmer's survival. Abstracting structures
as objects doesn't make things any easier, since making assumptions about flow
control or memory allocation doesn't remove the dirt, it simply sweeps it under
the rug; and let's not even get into functional or logic programming.

Thus, given that programming seems to be an inherently unintuitive method and
programming languages being inherently hard to master tools, the only thing
that's left is to do it the other way around, i.e. struggle to adapt our
reasoning to our programs' structure[^4]: the existing programming paradigms
aren't enough to express what we want to achieve, so we have to combine them
and employ new methods of thinking, serving as right tools for the right tasks.
This is indeed a painful problem, but one that we must not ignore, so that it
doesn't bite us back when we least expect it.

Given this new context, the "goto" issue becomes but a drop in an ocean.
Surely, the damned instruction will still cause us trouble, but this is nothing
compared to expressing it in the form of continuations, which, by the way,
provide us with a way to formally reason about the whole thing. Programs, or
"processes", won't become any easier to visualise, but at least we'll have
proper ways of fighting the dragon.

Finally, I feel the need to mention that "structured" programming, like any
other programming paradigm in existence, deals poorly with corner cases. For
example, have you ever written a procedure that never returns? Well, I have,
and you can bet that you're running them each fraction of a second in your
operating system or some other obscure library that either does this because
it's more efficient, or because it *absolutely*, *needs to*, do this.

Silver bullets, holy grails, there are no such things. So I guess we'll just
have to run like hell away from our "goto"s; unless we really *need* to use
them.

[^1]: Why odd? Well, I would call it a branch of mathematics, but then many
mathematicians would reprove me for mixing algorithms, "design" and other
mumbo-jumbo, with mathematics. I could instead call it a branch of science, but
then physicists would tell me to take my abstract "oracle" toy-Turing machines
and go elsewhere. Every existing taxonomy would fail me, since Computer Science
is a distinct field of science, even though it makes use of or is used in all
the others.

[^2]: Available [online][2] or [as a pdf][3] file.

[^3]: We learn to play music, tennis, to do martial arts, make love etc., but
we don't learn it *consciously*. Rather, our brain learns the mechanism based
on trial and error and positive reward. I suppose this is well-documented in
literature, Pavlov's dog being one of the first examples that comes into mind.

[^4]: As any architect, or artist, the programmer should in theory know what
his goal is. His difficulty lies instead in finding the magic formula, the
right words, the proper chant, to make the pieces fall into place so that their
composition does whatever they intended it to. Sounds so easy, doesn't it?

[1]: http://mitpress.mit.edu/sicp/full-text/book/book.html
[2]: http://www.u.arizona.edu/~rubinson/copyright_violations/Go_To_Considered_Harmful.html
[3]: https://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF
[4]: https://www.cs.utexas.edu/users/EWD/transcriptions/EWD10xx/EWD1036.html
