---
postid: '03c'
title: The myth of "software engineering"
date: August 9, 2015
author: Lucian Mogoșanu
tags: tech
---

In his post "[Propositions as Filenames, Builds as Proofs: The Essence of
Make][atkey]", Bob Atkey describes the `make` build utility as a tool for the
construction of proofs based on a set of rules, in a similar (or at least not
dissimilar) way to Prolog. This makes Makefile a logic programming
(meta)language used to describe build pre and post-conditions, plus
(optionally) the contract implementation, i.e. *how* the rule can be applied
once the pre-conditions are met.

Aside from describing the fundamental model, the post also makes a short yet
interesting comparison with other build tools:

> Many alternatives to `make` have been proposed. Motivations for replacing
> `make` range from a desire to replace make's very Unix-philosophy inspired
> domain-specific language for describing build rules (Unix-philosophy in the
> sense that it often **works by coincidence**, but falls over if you do
> something exotic, like have filenames with spaces in, or have an environment
> variable with the “wrong” name), or `make`'s slowness at some tasks, or a
> perception that `make` doesn't treat the `make`-alternative implementor's
> favourite programming language with the special treatment it so obviously
> deserves.

These points, and specifically the point regarding the Unix philosophy, are
uncoincidentally the same as those brought in the "SysVinit versus
[systemd][systemd]" debate: while init scripts have various issues, performance
being but one of them, the hard separation between policy and the actual `init`
implementation is what makes system administrators prefer the legacy solution
rather than the new, full-featured stuff. On the other hand, the fact that
systemd boots faster brings a null advantage to system administrators, since
they want to maintain machines that are rebooted very rarely (if ever).

These examples are but a few illustrations of the crisis of the field of
software engineering, more specifically the "engineering" part. As much as I
don't like quoting [Wikipedia][wikipedia], it provides a few very good
definitions of the term's meaning:

> Typical formal definitions of software engineering are:
>
> * "the application of a systematic, disciplined, quantifiable approach to the
>   development, operation, and maintenance of software";[^1]
> * "an engineering discipline that is concerned with all aspects of software
>   production";[^2]
> * and "the establishment and use of sound engineering principles in order to
>   economically obtain software that is reliable and works efficiently on real
>   machines."[^3]

The first and last definitions are particularly good, stating that software
development needs to be systematic and that it needs to rely on theory, method
and principle. That is, the outcome of the development process must rely solely
on the requirements and the end result should be quantifiable in the scientific
sense of the word. Also, the duration of the development process needs to be
estimated with a good degree of accuracy[^4], not only for the sake of
providing the engineers with determinism in terms of costs and not only for the
sake of providing a "time-to-market", but also to be in line with the "theory,
method and principle" guideline.

This is very far from the current state of the software industry and
software[^5] engineering. Software engineering methods and principles do exist,
only they are either faulty by design[^6] or they involve throwing an army of
developers at some particular problem[^7]. This process "scales" in the sense
that the end product will be "good enough"[^8], but the costs involved are so
big that they would be better spent trying to improve software quality by
design. That is not to say that software engineering should not involve any
hacking at all; on the contrary, only that hacking should not come at the
expense of science.

To add insult to injury, the complexity of most real-life software systems
requires the software engineering process to scale up, and this has nothing to
do with code. Writing code is cheap, sound design is however mind-bogglingly
hard, and at the same time essential[^9]. At the same time software complexity
conflicts with two aspects of software engineering.

The first aspect is that of establishing requirements. While simple systems,
say, real-time DPSs, have well-defined requirements, some of the complex
systems are subject to requirements that are often ambiguous. "Engaging users"
isn't a non-ambiguous requirement[^10] and thus making software to meet it is a
joke. Even some of the seemingly clear requirements are in fact hard to
establish: for example building a platform to facilitate communication between
people is a hard problem: doesn't IRC satisfy this requirement? don't blogs
satisfy it? why are people looking into "integrated" products?

Secondly, [software specification is the bottleneck][microkernel-verification].
Again, it is fairly easy to specify simple systems, even when they are built as
isolated components of larger systems, such as, say, software control
components for automobiles. It's however very difficult to specify a social
network, given that the term itself is ambiguous. Is IRC a social network?

This isn't to say that there aren't large systems that can be formally
specified: Bitcoin is one such example. Facebook, on the other hand is a
counter-example. This is incidentally why Bitcoin [is infrastructure][bitcoin],
while Facebook cannot, and never will attain that status. This proves the point
that the concept of social network, even if we don't view it as a marketing
object, doesn't make sense in the context of software engineering.

This in turn shows that software engineering has become somewhat of a myth.
It's not only that it's hard to make reliable software, it's also hard to make
software that's *unambiguously useful*[^11]. Stallman's Emacs is reliable and
useful because it does one thing well[^12]. djb's qmail is reliable and useful
because it does one thing well. systemd on the other hand is not reliable and
useful, because it has "neat features". Google Play is not reliable and useful,
because "it's social".

Of course, this doesn't really matter to the user, it just makes developers'
lives a hell.

[^1]: “IEEE Standard Glossary of Software Engineering Terminology,” IEEE std
610.12-1990, 1990.

[^2]: Sommerville, Ian (2007) [1982]. "1.1.2 What is software engineering?".
Software Engineering (8th ed.). Harlow, England: Pearson Education. p. 7. ISBN
0-321-31379-8.

[^3]: "Software Engineering". Information Processing (North-Holland Publishing
Co.) 71: 530–538. 1972.

[^4]: You may interpret "good" in whatever terms you wish. However, a project
that was meant to last six months and lasts a year is usually no more and no
less than utter failure, whether we're talking about building software,
bridges, living apartments or spacecrafts.

[^5]: And hardware! You're most probably reading this using bad quality
hardware, but only because vendors are too keen on selling stuff that has a
"short life cycle". Remember that time when you used to buy a product and the
producers actually had to provide you with a strong warranty regarding how much
the hardware's going to last? Sure, this happens nowadays too... in theory.

[^6]: Let us stop for a moment and [bash][agile], purely for the sake of giving
example:
	
	> Agile software development is a group of software development methods in
	> which requirements and solutions evolve through collaboration between
	> self-organizing, cross-functional teams. It promotes adaptive planning,
	> evolutionary development, early delivery, continuous improvement, and
	> encourages rapid and flexible response to change.

	So, "agile" promotes "collaboration"; I'm guessing other methods don't?
	"Self-organizing, cross-functional" teams, okay, not bad, if by
	"self-organizing" we don't mean "systematic chaos". "Adaptive planning" is
	another term for "we can't really meet our deadlines and we don't want to
	be brutally beaten once that happens"; "evolutionary development" doesn't
	really mean anything other than "we don't know what our product's gonna
	do"; "early delivery" is another term for "late delivery"; "continuous
	improvement" is... really, I don't think I need to go further.

	In short, "agile" has nothing to do with actual software engineering and
	everything to do with kids sitting around and tapping on their keyboards,
	with absolutely no idea what they're doing. The fact that some of them
	manage to pull out a product is coincidence.

	However, that is not to say that development methodologies themselves are
	bad, but rather that they are generally profoundly unscientific and thus
	should be regarded more as guiding principles rather than rigid
	constraints. Consider this the next time you start a new project.

[^7]: It's okay, other areas of engineering require low-paid plumbers too...
just in case you thought "software developer" meant more than that. And no,
your computer science degree has no actual value.

[^8]: Yes, it has some bugs, but the sheep won't complain. They'll also buy the
next iteration anyway.

[^9]: This is why bridges don't fail. This is why airplanes don't fail. Good
design, from top to bottom, is what drives a good end product.

[^10]: It has some potential to be, though, and it would have been if sociology
were a real science. Alas, it's not.

[^11]: Facebook is also a good advertising platform, right? Google is also a
good advertising platform, right? Right. It's left to the users to judge for
themselves whether this is "unambiguously useful".

[^12]: In case you're wondering what that is, like the troll you are, it's
extensibility. And yes, I am writing this in vim.

[atkey]: http://bentnib.org/posts/2015-04-17-propositions-as-filenames-essence-of-make.html
[systemd]: /posts/y01/02b-how-and-why-systemd-has-won.html
[wikipedia]: http://en.wikipedia.org/wiki/Software_engineering
[agile]: http://en.wikipedia.org/wiki/Agile_software_development
[microkernel-verification]: http://arxiv.org/abs/1211.6186
[bitcoin]: /posts/y00/01f-bitcoin-as-infrastructure-i.html
