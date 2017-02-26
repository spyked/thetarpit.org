---
postid: 01c
title: 3D printing: what you (probably) haven't considered (yet)
excerpt: A few predictions regarding the future of open hardware.
author: Lucian Mogoșanu
date: March 22, 2014
tags: asphalt
---

A couple of days ago I was reading an article called "[The Hardware Hacker
Manifesto][1]", in which the author laments on the sorry state of user freedoms
in regard to hacking devices. He makes a fine point, but he only barely
scratches the surface of the problem with the tip of his finger; because let's
face it, "hardware hacking" wouldn't be possible without the help of actual
open hardware, as well as "software hacking" wouldn't be possible without
actual "open software", be it "open source" or "free software".

In a fashion quite similar to software, hardware offers various degrees of
freedom. The main difference between the two lies in the nature of the
restrictions which get to be applied upon users or hackers: while software
artificially imposes a so-called "license" which allows or disallows the user
to modify, redistribute or sell a given program, hardware restrictions are,
well... hard. Vendors could in theory come up with a piece of silicon on a PCB
along with a schematic of said PCB, and market it as "open"; this already
happens in practice with the Raspberry Pi, Arduino, Galileo and other wonderful
pieces of hardware. There's only one tiny problem about them: they're not open,
or rather, they're not fully open.

So at this point you find yourself in the rather nasty situation of trusting
the chip producers[^1]. Even more, you find yourself in the even nastier
situation of trusting the chip designers[^2]. So what's all this nonsense about
"trust" anyway?

Well, for example Intel implement this neat instruction called [RdRand][2],
which is supposed to provide users with a "trustable" source of random numbers.
There is however a non-zero, and most probably non-negligible, probability that
Intel, being an American company, are politically influenced by parties which
are anything but trustworthy, namely the NSA, nowadays hated by most people who
have an interest in security. The same goes for any other hardware
manufacturer, which begs the question: are we going to implement our own
pieces of hardware anytime soon?

This isn't news; open hardware enthusiasts have been thinking about this for
[more than a year][3] now. The goal is attainable not only with a CPU, which
can be easily designed by a second-year Computer Engineering undergrad, but
also with GPUs and other high-performance hardware that would catch highly
secretive hardware makers such as Nvidia off-balance. This is doable, in fact
[MIPS cores][4] have provided a starting point for years, while [OpenRISC][5]
has the true potential of becoming the Linux of hardware. Still, there's only
one tiny problem about that: we don't have the technology to brew our custom
pieces of silicon at home; not yet.

Surely, FPGAs are a fairly good solution, although their cost can go at least
one order of magnitude higher than the Raspberry Pi. Still, FPGAs are more
trustable than a Pi, while ASICs are even more trustable and expensive as shit.
Otherwise if you're looking for security at the expense of large-scale
integration, then you might as well go solder your own stuff, just like dad
used to thirty years ago.

Now consider the following idea: at the time of writing, the costs of 3D
printers vary about the same as FPGA costs. Printing electronics is still a
[hot research topic][6], so by the time this goes mainstream, FPGAs will
probably cost less than the Raspberry Pi does now. Single-board computers will
probably cost less than $5. A couple of decades later everyone and their dog
will be able to print custom phones, or even better, hire robots to design
their favourite tech junk according to some informal specification.

I'll admit that I'm sounding like an over-optimistical prick right now. But as
a science and technology enthusiast and a person with an educated view on the
subject, I predict without even the slightest hint of optimism that this will
certainly happen. Mark my words, there's no way around it; it's either this or
the dark ages.

More in the news:

* [The $12 Gongkai Phone][7]
* [Debian Ported To OpenRISC Architecture][8]

[^1]: Intel, Texas Instruments, Samsung, Freescale or some other more or less
American hardware manufacturer.

[^2]: Intel, ARM, IBM, Nvidia and that's kind of where the story ends. See how
they're all western? Even if we take ex-designers such as Sun (now Oracle) or
MIPS Technologies (now Imagination Technologies), we still remain on the "left
side" of the world. Also, the list is pretty short.

[1]: http://daeken.com/the-hardware-hacker-manifesto
[2]: https://lwn.net/Articles/453651/
[3]: http://lkcl.net/articles/fsf_endorseable_processor.html
[4]: http://opencores.org/project,plasma
[5]: http://www.openrisc.net/
[6]: http://www2.warwick.ac.uk/newsandevents/pressreleases/engineers_pave_the/
[7]: http://www.bunniestudios.com/blog/?p=3040
[8]: http://www.phoronix.com/scan.php?page=news_item&px=MTYxNzM
