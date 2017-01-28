---
postid: 04a
title: On security
date: May 29, 2016
author: Lucian Mogoșanu
tags: cogitatio
---

It happens that I have some degree of familiarity with what people
nowadays call "security", as at the moment of writing this essay I am
pursuing my PhD[^1] in operating systems security, a topic which is
currently quite fashionable, although it wasn't (as) fashionable when I
started studying it[^2].

Fashion aside, one must remember that security has existed as a term
long before the appearance of computers. Let us defer to our friend
Merriam-Webster:

> Simple Definition of security
>
> : the state of being protected or safe from harm
>
> : things done to make people or places safe
>
> : the area in a place (such as an airport) where people are checked to
>   make sure they are not carrying weapons or other illegal materials

For the moment we can leave aside the fact that the last definition is
outrageously meant to educate plebs that they oughta become subject to
controls in the airport, *or else*; even more simply put, security is
that state where people don't need to fear invaders pillaging their
goods, raping their wives and bombing their train stations. From this
one may derive more specific definitions, such as that of security as a
financial asset or as a property of computing systems.

This stake being set in the ground, the educated citizen of the world
must acknowledge that security is not something that can be
mathematically or scientifically proven, despite several claims to the
fact[^3]. Scientifically proving that "something is secure" is not much
different from showing that masturbation causes skin degeneration: the
maths might work in some spherical-chicken-in-vacuum cases, but they
can, and if they can then they will fail in most real situations.

That isn't to say that there is no such thing as an abstract definition
or model of security. The most intuitive way to look at a system's
security would be to find that which gives it resistance to outside
forces. For example the membrane of a biological cell allows some
substances to enter and exit it, but not all of them. Similarly, a
computer that is physically disconnected from a network will be
protected against malicious agents running on said network, as opposed
to software running in the broken [cloud][cloud]. Similarly, a country
with strict border policies will always be more secure than one allowing
unconditional free passage[^4]. And so on.

A fact often overlooked by today's [failingly][failure-marketing]
[post-religious][post-religion] yet
[politically correct][political-correctness] Western civilization is
that there also exists a cultural definition of security. Cultural
artifacts, starting from language and continuing with literature,
philosophy, science and general knowledge and understanding of life, are
what define a group and what separate it from other
cultures[^5]. Dickens and Austen are products of British culture because
by understanding them you will become somewhat more of an Englishperson,
while the Russians can only be permeated by reading through Dostoyevsky,
Pushkin, Tolstoy et al. Similarly, China is a strong country precisely
because you do not easily understand their culture, while the North
American post-culture -- or pop culture -- is a good example of poor
culture, since it can be too easily permeated, understood and laughed at
by almost everyone else, save Africa.

This is also why my PhD thesis may prove to be in the end
useless. Today's technical culture is erroneously trying to solve
cultural issues using technical means[^6]: people bitch about privacy
issues, but they use the all-snooping Facebook to communicate and
ever-snooping Google to find things; they want to keep their data safe,
but they use cloud services; ultimately, they prefer convenience at the
cost of responsibility. The bad thing about this is that this is
spreading through other fields (say, education), and the mind-numbingly
worse thing is that nature induces (often hidden) costs for everything
we do.

The trade-off is simple, albeit not provable scientifically. One can
either [choose to become human][humanity] and fight until the end of
their days to get themselves removed from the tar pit that is inculture,
or they can choose to trust Facebook, Google, or for that matter the Big
Brothers that were/are Hitler, Stalin and NSA, and be left with nothing
of their own. Or as a very wise man once said[^7]:

> Those who would give up essential Liberty, to purchase a little
> temporary Safety, deserve neither Liberty nor Safety.

[^1]: The reader must remember that PhD degrees don't hold the same
    value as they did, say, fifty years ago. This is mainly due to
    causes of [academic hogwash][hogwash].

[^2]: This was a while before Heartbleed, Shellshock and their no less
    damaging follow-ups. At the time people were only starting to
    scratch the surface of Android's -- which is what people initially
    thought would be a fundamentally "more secure" operating system --
    [shortcomings][android], despite the fact that Android doesn't
    really address any real fundamental issues currently being
    researched in the field of [operating system design][os-design].

[^3]: Back when I started my PhD, I was deeply fascinated by
    seL4. Having grown a little, I now understand that employing an army
    of mathematicians to solve the intractable problem of proving the
    correctness of a kernel will neither protect against system
    designers who misunderstand the OS kernel they're using, nor against
    faulty hardware -- see Wojtczuk and Rutkowska's 2009 paper and
    Domas' 2015 paper on Intel CPU exploits, to name only a couple of
    examples.

[^4]: In case you're wondering why the Schengen agreement is now proven
    to be a failure. Also read [Popescu's post][trilema-schengen] on the
    matter.

[^5]: This is for example how the Japanese, despite being a few people,
    survived throughout the millenia, only to be labeled as xenophobic
    by the stupid Westerners of our time.

[^6]: Of the "AI is going to improve our lives in so many ways"
    sorts. We are however not so keen to evaluate the ways in which AI
    will make our lives more miserable, or the ways in which we will
    make ourselves more miserable in order to fit the world views of
    AI. This too will be part of Westerners' undoing.

[^7]: From Ben Franklin's Reply to the Governor, supposedly available
    online when the [site][franklin] isn't down.

[hogwash]: /posts/y02/045-academic-hogwash.html
[android]: /posts/y02/03f-android-the-bad-and-the-ugly.html
[os-design]: /posts/y01/03a-the-linguistic-barrier-of-os-design.html
[cloud]: /posts/y02/041-cloud-software-is-unreliable-ii.html
[trilema-schengen]: http://trilema.com/2013/no-seriously-not-much-of-a-priority-anymore/
[failure-marketing]: /posts/y02/043-on-the-failure-of-marketing.html
[post-religion]: /posts/y00/018-on-post-religion.html
[political-correctness]: /posts/y01/02e-on-the-inherent-harmfulness-of-political-correctness.html
[humanity]: /posts/y01/032-your-worth-to-humanity.html
[franklin]: http://franklinpapers.org/franklin/framedVolumes.jsp?vol=6&page=238a
