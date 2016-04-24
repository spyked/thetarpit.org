---
postid: '010'
title: Haskell, the Lego of programming
author: Lucian Mogoșanu
excerpt: In which I argue the utility of functional programming in education and day-to-day activities.
date: September 22, 2013
tags: asphalt, tech
---

I'm unsure of what train of thought this article with follow, or what its main
idea is supposed to be. But here I go.

Haskell is a functional programming language. It's "functional" as in
"mathematical function", and it was designed by mathematicians. It's not the
only one (I'm sure most of you remember the great Lisp), but it's special in
its own way, mostly due to the fact that the guys that made it took some rather
obscure concepts and integrated them into the language.

Haskell not only describes programs as functions, but it also describes them as
equations. That's far, far away from what one would expect from most mainstream
programming languages, although it's not *that* special: we all did it before
in school when writing down function definitions, or trying to find a
reasonable explanation of why some polynomial has no real roots, or doing
integral calculus, and so on. Haskell is a computational expression of these
concepts, nothing more, but nothing less either, since it's quite a big thing
to be able to describe hard, formal facts as programs.

Programming with functions, not any functions, but some really weird morphisms
that have *types* attached to them, is very much like fitting Lego pieces
together[^1]: you combine a couple of little pieces to make a bigger piece,
which then you use to make something useful, or maybe just fun. Of course, like
all programs, Haskell programs have their own set of problems, given that there
is no abstraction heaven in reality; more like an abstraction hell, actually.
However, under a keen mind and a pair of trained fingers, such a language can
provide a smooth, sometimes even enjoyable ride through hell.

So what's the point of all this?

Well, it's possible that you have a child, and he or she is, at his or her
fragile age, very open to new things, technology, shiny things, *fun* stuff. My
advice to you is not to hesitate: grab a Scheme or Haskell interpreter and
teach your kid how to play with numbers, strings, diagrams, web pages, all the
stuff that makes today's technology worthwhile. Let them go to an introductory
course, but make sure that doesn't stifle their creativity. They are after all
brilliant minds in the making. I'm not a psychologist, but I can suggest that
you spare some time and study with them, and play with them, as any good parent
should do.

Or maybe you're not a parent. Maybe you wanted to learn more statistics in
college but never got around to it. You keep hearing about big data, analytics
and other buzzwords which gravitate around one thing and one thing only:
mathematics. Or maybe you're an experienced programmer, or an actor. To be
honest, I don't think it makes any difference: go and learn a "high-level"
language, one that's more "formal", one that challenges your thinking. I'm not
going to suggest you to learn APL[^2], but really, Scheme's a great language
for messing around. Or maybe you're a Java programmer and you'd like to go try
Scala or Clojure, or you're into .NET and F# might be closer to your mindset.
Whatever, just find one or two or three languages and write something useful,
like a program that does your bills or a porn crawler.

Yes, I know, I'm biased, but I also happen to be right. It's not like I get any
pleasure from it, but I'm hoping that fluttering it in front of everyone will
make a difference.

[^1]: The type system is thus a mechanism which has the primary function of
verifying that pieces fit into place.

[^2]: It's [A programming language][1]. A highly esoteric one, more so than
Haskell.

[1]: http://groups.engin.umd.umich.edu/CIS/course.des/cis400/apl/apl.html
