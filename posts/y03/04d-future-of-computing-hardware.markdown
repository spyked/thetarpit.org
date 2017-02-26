---
postid: 04d
title: On the future of computing hardware
date: August 7, 2016
author: Lucian Mogoșanu
tags: asphalt, tech
---

One, systems tend to get smaller.

Mathematicians with an inclination for studying so-called "systems" may
without much effort look at various examples of such "systems" and
devise quantitative measures of complexity. For example the mammal's
organism is highly complex on various levels of abstraction, say, when
looking at its average genetic makeup; the same can be said about social
networks[^1], global weather[^2] or the motion of stars.

These complexities are however against the intuition we have in
engineering. That is because human-made systems are not only designed to
be functional, but to also be as deterministic as possible; and such
determinism cannot be achieved without a proper understanding of the
theoretical model used in designs and *especially* its
limitations. "Simplicity is the ultimate sophistication", and
"everything should be made as simple as possible, but no simpler", but
also "simplicity is prerequisite for reliability", to quote only a few
aphorisms.

We can observe empirically that systems' complexity, or rather some
measure of their "size", evolves cyclically. Dinosaurs evolved to be
huge creatures, only to be replaced in time by miniaturized versions of
themselves[^3]. The first simple computing systems had the size of a
room, while large-scale integration has led to computers which fit on
the tip of one's finger. This reduction in size comes with reduction in
certain features' size and/or complexity, which is why for example
humans don't have tails, nor the amount of body hair of some of their
ancestors, nor sharp canines.

Looking at the evolution of various industries in the last few
decades[^4], it is clear that they are currently in the latter phase of
the growth-reduction cycle. It is only natural that the so-called
hardware, and more specifically numerical computers made out of
silicon[^5] will follow.

<p style="text-align:center; font-weight:bold;">⁂</p>

Two, on shaky foundations; transcending ideological confusions.

The fact that nowadays' hardware industry stems from the needs of
[marketing][marketing], as opposed to the needs of the market, is
well-known. This charade started with personal computers, then it was
followed by mobile phones, tablets, and now so-called "smart devices"
from "the Internet of things", which operate in cycles of what is known
in economics as "planned obsolescence"[^6].

Purely from the perspective of computing hardware, this leads to the
proliferation of functionality that is useless, or worse, harmful to
the average consumer. For example the new generation of Intel Skylake
processors come with Intel SGX, Intel MPX and possibly others; all this
at the expense of reliability[^7], and at the same time without
advancing the state of the art in any fundamental sense. All they do is
offer some clients new ways to shoot themselves in the foot, and Intel
are by no means a singular case[^8].

Degrading processor quality aside, there are quite a few pragmatic
factors lying behind the existence of the planned
obsolescence-aggressive marketing vicious circle. For one, it's easier
to scale silicon production up than to scale it down, as it's more
effective to fabricate a large wafer containing smaller and smaller
processors than to produce in smaller numbers[^9]. Meanwhile, some of
the steps in the manufacturing cycles (still) require significant human
workforce (for the time being), which makes eastern Asia the prime
choice for production[^10]. Thus the per-unit cost of producing a
processor is higher for smaller batches (say, a hundred at most), while
e.g. smartphone assembly in high numbers will necessarily rely on
poorsters in China.

This context however underlies a problem of a more ideological nature,
that has been recently, yet unfruitfully, [discussed][freedom-x86] in
the free software world: there is a general lack of choice in
general-purpose hardware architectures, and given the situation above,
it's not likely that this will improve. We are most likely heading into
a duopoly between ARM and x86, while the fate of MIPS is not quite
certain[^11], IBM's Power is somewhat expensive and FPGAs likewise,
barring the very low-entry ones. The open RISC-V architecture offers
some hope, given Google's interest in them, but I wouldn't get my hopes
up just yet.

This is not the first time I am writing about this. I have touched on
the subject on [the old blog][hardware-liber] a while ago, and I have
also discussed some of the (still current) issues in a previous
[Tar Pit post][3d-printing]. People don't seem to have gotten their
heads out of the sand since then, so I will reiterate.

<p style="text-align:center; font-weight:bold;">⁂</p>

Three, I want to build my own hardware.

To be honest, I don't care too much about Intel, Qualcomm, Apple and
their interests. If Romanians were building their own computers[^12]
back in the days before "personal computer" was a thing, then I don't
see why I couldn't do this in the 2010s. Whether it's made feasible by
3D printing, some different technology or maybe some hybrid
approach[^13], this is a high-priority goal for the development of a
sane post-industrial world and in order to pick up the useful remains of
the decaying Western civilization. However one would put it, small-scale
hardware production is the next evolutionary step in the existence of
numerical computers.

It is readily observable that[^14] the computer industry is heading
towards a mono-culture, not only in hardware, but also in operating
systems[^15] and in "systems" in general. This will -- not might, not
probably, but definitely -- have the effect of turning the "systems"
world into a world of (often false) beliefs, much akin to Asimov's
Church of Science, where people will not even conceive the possibility
of existence of other "systems".

I am of course not crazy enough to attempt to stop this. The industry
can burn to the ground as far as I'm concerned, and this it will, and
it'll be of their own making. What I want is to gather the means to
survive through this coming post-industrial wasteland.

[^1]: By which I mean specifically not the jokes the average Westerner
    calls "social networks". Facebook, Twitter, Reddit et al. are only
    networks in the sense that they reduce the level of interaction to
    at best that of monkeys throwing typewriters around; at best. The
    average level is rather Pavlovian in nature.

[^2]: Weather, not climate. Mkay?

[^3]: Which taste like chicken.

[^4]: Popescu's "[The end of democracy][trilema-democracy]" is required
    reading on this matter.

[^5]: Unless some other better, faster, stronger material takes its
    place. Which I kind of doubt, given that science is also
    [in a period of stagnation][academic-hogwash], and that is putting
    it very mildly.

[^6]: Which, although probably perceived by the naïve as capitalist, is
    rather reminiscent of the old communist planned economy model. And
    not unlike communist economy, it often leads to higher prices and
    lower quality products. To bear in mind next time you're buying that
    new Samsung or Apple smartphone.

[^7]: Dan Luu's
    "[We saw some really bad Intel CPU bugs in 2015, and we should expect to see more in the future][dan-luu]"
    is required reading on this particular matter.

[^8]: ARM are somewhat more conservative, but they offer SoC producers
    enough freedom to shoot their clients in the foot. Without any
    doubt, the average Qualcomm phone is most probably running Secure
    World software that the end user will never care about, and that the
    curious mind will never have the chance to reverse engineer --
    without considerable financial resources, anyway. That's a good
    thing, you say? Well, it's your opinion, you're entitled to it,
    please stick it up your ass.
    
    But what am I saying? By all means, please *do* buy whatever shiny
    shit Apple or Samsung are selling you. As long as it's not *my*
    money...

[^9]: There are quite a few technical reasons for this too, and some of
    these escape me. For one, opening a semiconductor plant isn't
    exactly cheap, and the ratio of defects to units produced is
    significant, yet in principle easy to estimate statistically. The
    cost of making a circular wafer is also not small, which makes
    economic feasibility a tricky thing. Meanwhile, bear in mind that
    Moore's law is on its way to becoming dead and buried, given that
    CMOS-based technologies are reaching their physical limits.

[^10]: To be perfectly clear, the world's largest silicon producer is at
    the time of writing not Intel, but Taiwan Semiconductor
    Manufacturing Company, Ltd.

[^11]: Imagination Technologies, the intellectual property holder, have
    not been faring too well in 2016.

[^12]: Remember the story of the [ICE Felix HC][balls-clean] that was
    the toy in my early computing days, before I had the slightest idea
    of what an algorithm actually was. Now ponder the fact that there is
    no *qualitative* difference between that piece of junk and today's
    latest, greatest, whateverest computer. Yes, you can do the exact
    same things on that old heap of junk, and by "exact" I certainly do
    not mean watching porn, by which I mean that this is why your
    children will prefer make-believe sex instead of fucking real women,
    which uncoincidentally is why Arabs are the superior ethnicity and
    those God-awful political corectnesses will stop being a thing in
    less than a generation. But I digress.

    As a funny historical footnote, the same Romanians attempted at
    making [a Lisp machine][dialisp] back in the '80s, which makes me
    hopeful that the same thing should be achievable almost three to
    four decades later. I hate repeating myself, but it's quite
    literally either this or the dark ages.

[^13]: The approach itself is relevant only as far as it solves the most
    problematic economical aspects, i.e. logistics (needs to be made
    using readily available and/or easily procurable materials) and low
    production costs of a small number of units (tens to a few hundreds
    at most). Processing speed and size are secondary aspects, a Z80 (or
    maybe something equivalent to a 80386) should really be enough for
    most general-purpose-ey uses.

[^14]: Much to the baffling ignorance of otherwise intelligent
    people. Unfortunately for them, nature abhors singularities; as one
    of the older and wiser men in the Romanian Computer Science
    community used to remind us, there is, simply put, a cost for
    abso-fucking-lutely everything in life.

[^15]: In case you were wondering, despite being the most usable kernel
    to date, Linux is definitely *the* ultimate abomination. Its
    greatest feature is that it's not too difficult to strip of all the
    crap.
    
    If you don't know what I'm talking about, take a look at
    [CVE-2016-0728][cve-2016-0728] for example.

[trilema-democracy]: http://trilema.com/2016/the-end-of-democracy/
[academic-hogwash]: /posts/y02/045-academic-hogwash.html
[marketing]: /posts/y02/043-on-the-failure-of-marketing.html
[dan-luu]: http://danluu.com/cpu-bugs/
[freedom-x86]: http://mail.fsfeurope.org/pipermail/discussion/2016-April/010912.html
[hardware-liber]: http://lucian.mogosanu.ro/bricks/viitorul-hardware-ului-liber/
[3d-printing]: /posts/y00/01c-3d-printing.html
[balls-clean]: /posts/y01/035-with-our-balls-clean.html
[dialisp]: http://www.atic.org.ro/ktml2/files/uploads/Masina%20DIALISP.pdf
[cve-2016-0728]: https://security-tracker.debian.org/tracker/CVE-2016-0728
