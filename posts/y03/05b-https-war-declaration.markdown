---
postid: 05b
title: A declaration of war on the HTTP of Shit
date: March 12, 2017
author: Lucian Mogoșanu
tags: asphalt
---

It has been known for quite a while now that Google are
[waging a war][chrome-https] on plain HTTP with their Chrome web
browser. They are openly leveraging their browser's popularity and their
political power to force web server owners to provide services
exclusively through HTTPS, that is, the HTTP of Shit. This is all nice
and well, only, as it happens, I personally don't care.

Let us be clear about this: HTTPS is not secure. The simple fact that
Google claims HTTPS to be secure does not make it so. It does not make
it so from a political point of view, since the "secureness" property of
HTTPS only extends as far as Google's own political arm can reach, which
arm cannot for example reach this blog. It also does not make it so from
a technical point of view, despite the so-called "experts" having you
believe it "just works". No, it doesn't, and for some very specific
reasons.

But before going into technical details, let us define what "security"
means in this context. From a purely theoretical point of view, the TLS
family of protocols have been designed to give their users three
properties: confidentiality (communication over a given medium cannot be
easily intercepted), integrity (data cannot be easily tampered with or
otherwise corrupted) and authenticity (the source of given data is
verifiable). The first property is enforced through encryption; the
second is enforced through sealing[^1] (which for our purposes is
equivalent to encryption); while the third is enforced through signing.

Distributed communication systems[^2] are fraught with many problems,
two of them being: the meta-problem of authenticating the instruments of
authentication (i.e. the keys, and more importantly, their owners) and
the problem of invalidating said instruments (i.e. key
revocation[^3]). The two problems are unresolvable. Let me explain what
I mean by this: "unresolvable" means "not solvable using technical
means", which means that so far science has given us no sound solution,
and searching for one is not so different from looking for a solution to
the P vs. NP problem or for a device that can reverse entropy[^4].

Having said that, TLS, and thus HTTPS, proceeds to solve this
unresolvable problem; and it does this using two of the worst possible
approaches.

The first approach is to make the protocol's implementation a hack, with
the purpose of (as much as possible) providing "universal support"[^5]:
support all the key exchanges algorithms, all the encryption algorithms,
the newest, the latest, the greatest (if possible) algorithms. All this
bloat and clutter is what has spawned what you may know as Heartbleed;
or DROWN; or BEAST; or many, many other attacks on faulty
implementations which are anything but maintainable.

The second approach is to base the protocol upon a centralized model of
key generation, exchange and revocation, the Public Key Infrastructure
model. The model is, granted, attractive to socialists, because it
follows from the basic assumption that Alice and Bob are not able to own
their keys, so someone needs to own them for them, to distribute them
and revoke them in case of incidents[^6]. This, like all
[socialist systems][mechanics-of-socialism], has (among others) the
problem that it creates single points of failure. This is how you got
the DigiNotar compromise, the VeriSign compromise and others.

Thus we can claim that not only TLS, and thus HTTPS, is not secure; we
can claim that it is *antithetical to security*. To be clear: I don't
claim that they don't "just work". They do "just work", to the degree a
shabby hut works: at the first earthquake or thunderstorm wind, it will
fall; and when it does, it will fall *hard*, à la the "too big to fail"
nonsense. And when it does, the first to suffer will not be the gang of
idiot programmers, Google engineers or IETF bureaucrats; it will be the
"users" of this fragile construction.

This lengthy introduction being laid out, I wish to formally issue a
declaration of war on the HTTP of Shit, also known as HTTPS. This
entails an open war with Google, The Linux Foundation, Facebook and
pretty much every entity listed as a sponsor on the
[Let's Encrypt][lets-encrypt] web site. There isn't much that this
declaration of war entails, as myself and my blog are very small pieces
in this puzzle, but I hope for it to serve as an example for all those
who share the philosophy described here.

The Tar Pit's hosting web server will pointedly not use HTTPS for the
foreseeable future, which will result in it being marked as "not secure"
by browsers such as Chrome in the near future, and all that for
arbitrary reasons. Furthermore, in the near future[^7] The Tar Pit will
remove all support for Chrome: the HTML dialect will probably be limited
to around version 4, the CSS decorations will go away and the so-called
"web fonts" will have to hit the proverbial dirt as well. The interface
will perhaps not look so fancy as it does now, but alas,
[everything costs][freedom-is-slavery]. I will however make sure that
the blog looks and acts decently in lynx, w3m, Dillo and maybe Firefox,
which should be more than enough.

As for Google Chrome: let it be the most popular ever, and let it
continue being useful for browsing the Internet of Shit, using the HTTP
of Shit. Collectivist computing[^8] is not needed around here, nor is it
useful in any general or particular way.

[^1]: See Nick Szabo's [The Playdough Protocols][szabo] for further
    details on sealing.

[^2]: Not necessarily computing systems, but distributed communication
    systems in general. For example a system comprising Alice, Bob and a
    messenger pigeon is *in principle* -- which is to say,
    *qualitatively* -- equivalent to a system comprising the same Alice
    and Bob communicating over the Internet.

    This is a more serious matter than a first glance would reveal:
    while the Internet is significantly faster, which gives it clear
    quantitative *as well as qualitative* advantages over other
    communication media, it is per its definition *qualitatively
    equivalent* to so-called "lesser" forms of communication. This is by
    and large a good thing, as it tells us that were the Internet to
    collapse, reality would not fall apart.

[^3]: Revocation is more related to the property of authorization than
    it is to authenticity, but there is a certain point, namely the
    philosophical realm of identity, where the two converge. Let's
    explain this.

    Let's say that Alice owns a key `K` and gives it to Bob and some
    other parties. At some point in the future, Alice may not want to
    use `K` to communicate anymore, for which purpose she wants to have
    a way to mark `K` as invalid, which is equivalent to uttering loudly
    "`K` is not mine anymore, so if you use it to communicate with me in
    the future, you do so at your own risk". This is a problem of
    authentication/identity, and its solution may lead to a weak form of
    forward secrecy.

    At the same time, upon uttering this, Alice revokes herself the
    *authorization* to use `K`: we assume she cannot change her mind in
    the future (which may be disastrous). This particular point is very
    important to our discussion, because as we see, in the framework of
    TLS and PKI, Alice does not own her key, but in fact some higher
    power does.

[^4]: This might seem like an exaggeration, but it's not. The discussion
    exceeds the current subject by far, but let's take a very brief
    example to illustrate the problem.

    Alice and Bob, having not known each other before, meet in person to
    exchange keys, which as far as I know is the most secure form of
    authentication in existence. Bob gives to Alice a piece of paper and
    says "here, this piece of paper contains my public key", and Alice
    does the same to Bob.

    And now comes the problem: are Alice and Bob supposed to trust each
    other? And if so, what protocol dictates this? And if not, why not?
    Can you grasp the problem at hand? How can we define trust without a
    pre-existing context?

    For our amusement, let us also define some contexts. Let's say Alice
    and Bob have a common friend who recommends each to each other: this
    reduces to the Web of Trust model, but what formal guarantees does
    this context give? Or let's say Alice and Bob's keys are generated
    by the Department of Key Generation in the
    [Socialist United State][we]: this reduces to PKI, which reduces
    Alice and Bob to cattle, but *what formal guarantees does this
    particular context give*? Humour me.

    Or let's step this up a bit, and assume that Alice and Bob are
    lovers who have known each other for thirty years, and spouses and
    whatnot. What formal guarantees do we have that Bob isn't gonna leak
    Alice's private key to his housemaid who gives him better fucks?
    What, you haven't seen marriages fail after thirty years? I have.

    Which problem reduces to that of [trust][the-problem-of-trust],
    which in turn reduces to entropy: what formal guarantees do (or
    can!) you have that, given enough time, your cells aren't going to
    fall apart?

[^5]: This "universality" snake oil is not new in the world of
    technology. See for example Popescu's article on
    [Unicode][unicode-is-stupid].

[^6]: Yes, PKI is a form of communism. I'll restate this in bold: **PKI
    is a communist concoction**. Now go and whine to your boss about how
    Lucian is gratuitously mean and all, while zhe, I don't
    know... fucks you in the ass or something.

[^7]: Meaning, as soon as possible. What, if Google, that is, the owner
    of a number of servers on the Internet, is allowed to state vague
    timeframes, why would I, the owner of a number of servers on the
    Internet, not be?

[^8]: As opposed to the personal kind. This is yet another philosophical
    and ideological discussion which needs an essay of its own, but
    until such an essay comes into existence, you can read the statement
    of [No Such lAbs][nsa], my posts on cloud software
    ([part one][cloud-software-i] and [part two][cloud-software-ii]) and
    many others.

[chrome-https]: http://archive.is/S4yT0
[szabo]: http://archive.is/Cjlr5
[we]: /posts/y02/04b-we.html
[the-problem-of-trust]: /posts/y03/059-the-problem-of-trust.html
[unicode-is-stupid]: http://trilema.com/2016/unicode-is-fucking-stupid-the-definitive-article/
[mechanics-of-socialism]: /posts/y00/017-the-mechanics-of-socialism.html
[lets-encrypt]: http://archive.is/pDJzm
[freedom-is-slavery]: /posts/y03/04f-freedom-is-slavery.html
[nsa]: http://nosuchlabs.com/
[cloud-software-i]: /posts/y00/00e-cloud-software-is-unreliable.html
[cloud-software-ii]: /posts/y02/041-cloud-software-is-unreliable-ii.html
