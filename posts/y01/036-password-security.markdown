---
postid: 036
title: Password security, a game theoretical approach
date: February 28, 2015
author: Lucian Mogoșanu
tags: cogitatio
---

In the age of computers and the Internet, passwords have been, are and will
remain a cornerstone concept when it comes to security in general and
authentication in particular, as the problem of choosing an efficient and
reliable means of authentication remains open. Moreover, its impact in the real
world is not to be underestimated, given that mostly everyone nowadays relies
on computers and, indeed, the Internet for their activities.

Given that there is no such thing as "100 percent security", there is no such
thing as a fully secure authentication scheme, a reality which is reinforced by
the dependency of all known forms of authentication on the human factor.
Speaking of which, there aren't that many authentication schemes out there.

One of the classical forms of authentication employed in real life is the
"third party" approach: if I need to do something which involves a second party
in the system, then I need to be authenticated by a third party, be it person
or machine. This scheme is widely employed on the Internet nowadays, whether by
the Public Key Infrastructure or by the various Webs of Trust. The problem with
this approach is that a third party might not always be available or it might
not be desired. Furthermore, even when a third party is specified in the
protocol, it itself will have to authenticate to the other two parties, leading
to a "chicken before the egg" problem; this is why, among others, cryptographic
protocols such as zero-knowledge proofs were conceived.

Other authentication factors are "something you possess" and "something you
are". The first factor is for example used to prove certain abilities possessed
by the agent, such as driving; in IT security, the so-called tokens providing
one-time passwords are a good example of ownership factors. The second factor
relies heavily on the usage of unique identifiers, e.g. fingerprint or retinal
patterns, DNA, voice, face, etc., to authenticate parties; humans obviously use
these features to identify other people; research fields such as computer
vision try to achieve the same thing, with some, yet limited, success.

Both authentication factors have been known to be successfully broken.
Possessed objects can be stolen and/or forged; fingerprints can be extracted
and forged; voice patterns and facial features can be reproduced, and so on and
so forth.  Identification is a difficult practical problem as much as it is a
deep philosophical problem.

Finally, passwords can be classified as the "something you know" factor. They
are similar in nature to cryptographic keys, in that they are secret, but
unlike keys, they are considered to be known by a human instead of somehow
generated or stored by the machine. Note that the terms "something you know"
and "secret" are generally poorly defined by those who use passwords in their
daily lives and they usually lead to security breaches, either due to the
user's ineptness or because of the protocol designer's incompetence.

Take the following scenario for example: you're the only person who knows that
your mother's name is Mary, leaving out, say, close people whom you trust; yet
choosing "Mary" or even "MymomsnameisMary" as a password is a bad idea, as
"Mary" is and has been so far a common name in the Western world, on the
Internet and in the known Universe. Any common word in the dictionary is a bad
idea, although more commonly-used *random* words should [increase the
password's security][passphrases].

These are more or less good advices and there are many more out there. But I
assert that in order to manage passwords efficiently, people, or at least the
ones who know what they are doing, need to rely less on policies and more on
general principles[^1]. One such principle can be built on the basis that
pretty much everyone and everything on the Internet can be thought of as agents
storing "secrets". I believe that the meaning of "secrets" can be defined using
the knowledge provided to us by the field of game theory, which (fortunately
for us) works with agents, viewed by us as refinements of some distributed
system such as the Internet.

Thus, let $A$ be a set of agents organized under some arbitrary topology[^2].
We assume $A$ is countable, so we can write

$A = \{a_1, a_2, a_3, \dots\}$.

We could probably form our argument on the basis that $A$ is finite, but it
might be useful to take into account infinity in case we want to model
asymptotic behaviour[^3].

In respect to password security every agent $a_i \in A$ knows[^4] a piece of
"secret" information (say, a string) $s_i$ not known by any other agent $a_j
\in A, a_j \neq a_i$. Additionally $s_i$ would be *hard to guess*, i.e. a
password-breaking algorithm, be it mere brute-forcing or dictionary, NLP
analysis etc., would take a long amount of time to find $s_i$. In other words,
assuming the system is made up entirely of agents that are rational with
respect to the security of their passwords, it has the following
characteristics:

* Every agent $a_i \in A$ has limited information
* For any agent $a_i \in A$, guessing the password of $a_j \in A, a_j \neq
  a_i$, i.e. $s_j$ would prove to be unfeasible

Note that these assumptions do not lead to an accurate model of reality: the
properties of $A$ would most probably yield a stable outcome, in that no agent
would find it useful, in the utilitarian sense, to try to break the password of
another agent. This obviously *doesn't* happen in real life, but it does tell
us how agents *should* choose their passwords in order to minimize their
chances of a breach, both from an algorithmic point of view as well as from a
social standpoint.

On the surface this looks like a platitude: choose a "hard to guess" password
and you're "approximately safe". However, both "hard to guess" and
"approximately safe" are once again vaguely defined terms; what truly helps us
is the observation that this game looks very similar to a rock-paper-scissors
match, wherein no agent has a true advantage over the other. In fancier words,
we're dealing with a game where an equiprobable mixed strategy leads to an
equilibrium; that is, assuming all the agents speak a common language made up
of symbols from a set $\Sigma$, *random* passwords from a finite subset of
$\Sigma^{*}$ would be "hard to guess".

Uncoincidentally, this is supported by the fact that so-called "strong"
passwords need to come from a pool of random letters and/or words, i.e. they
need to have a high entropy. This means that, for example, a password made up
of twenty "z"s is much easier to break than a password made up of twenty
randomly-chosen -- or rather randomly-generated by a machine -- letters, on the
simple basis that the human brain being inherently biased towards meaningful
information, it's more probable that it would generate a sequence of repeating
letters than a uniformly distributed set of letters.

By relaxing the problem to human agents, we can state that a "secret" password
must be:

* randomly generated from a set of characters and/or words and it must be long
  enough given the purpose it's used for, e.g. nowadays you'll need a
  ten-character password for most of the stuff you're using or a one
  hundred-character password to be safe from the NSA for the time being, and
* easy to remember.

Another example is that of [passphrases][passphrases] given by Randall Munroe:
passwords made up of four or more words in English are strong enough, as long
as they're randomly selected by a machine that has fairly strong random number
generation capabilities, *not* by a human[^5].

Passwords are not only important now, but they have the chance to be even more
important as they become adopted for systems such as
[brainwallets][brainwallet]. The above half-baked model merely scratches the
surface of defining a principled approach to password security, but it has the
potential to be used for true practical purposes, such as defining security
risks and policies for a set of applications where the system cannot be
strongly secure, but merely resilient. Of course, that is so far the curse of
the entire field of cryptography.

[^1]: It's not that policies are not useful or ineffective, but that they would
be better understood and they could be improved if they were conceived based on
a set of governing principles. My best guess (at least for now) is that
building a formal model from this game theoretical approach is possible and
possibly even feasible.

[^2]: I don't know whether the agents' organization and/or infrastructure is
relevant to the problem, but I will leave this detail out for the sake of
simplicity.

[^3]: The Internet is huge, and growing.

[^4]: And I'm guessing that epistemic logic would prove to be very useful here.

[^5]: Sorry Bruce, you're clearly wrong on [this one][schneier]. I'm actually
quite disappointed in you, y'know.

[passphrases]: /posts/y00/019-passwords-versus-passphrases.html
[schneier]: https://www.schneier.com/blog/archives/2014/03/choosing_secure_1.html
[brainwallet]: https://en.bitcoin.it/wiki/Brainwallet
