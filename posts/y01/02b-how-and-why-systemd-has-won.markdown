---
postid: 02b
title: How and why systemd has won
date: September 27, 2014
author: Lucian Mogoșanu
tags: tech
---

systemd is the work of Lennart Poettering, some guy from Germany who makes free
and open source software, and who's been known to rub people the wrong way more
than once. In case you haven't heard of him, he's also the author of
PulseAudio, also known as that piece of software people often remove from their
GNU/Linux systems in order to make their sound work. Like any software
engineer, or rather like one who's gotten quite a few projects up and running,
Poettering has an ego. Well, this should be about systemd, not about
Poettering, but it very well is.

systemd started as a replacement for the System V [init][init] process. Like
everything else, operating systems have a beginning and an end, and like every
other operating system, Linux also has one: the Linux kernel passes control
over to user space by executing a predefined process commonly called `init`, but
which can be whatever process the user desires. Now, the problem with the old
System V approach is that, well, I don't really know what the problem is with
it, other than the fact that it's based on so-called "init scripts"[^1] and
that this, and maybe a few other design aspects impose some fundamental
performance limitations. Of course, there are other aspects, such as the fact
that no one ever expects or wants the `init` process to die, otherwise the
whole system will crash.

The broader history is that systemd isn't the first attempt to stand out as a
new, "better" init system. Canonical have already tried that with Upstart;
Gentoo relies on OpenRC; Android uses a combination between Busybox and their
own home-made flavour of initialization scripts, but then again, Android does a
lot of things differently. However, contrary to the basic tenets[^2] of the
[Unix philosophy][unix], systemd also aims to do a lot of things differently.

For example, it aims to integrate as many other system-critical daemons as
possible: from device management, IPC and logging to session management and
time-based scheduling, systemd wants to do it all. This is indeed rather stupid
from a software engineering point of view[^3], as it increases software
complexity and bugs and the attack surface and whatnot[^4], but I can
understand the rationale behind it: the maintainers want more control over
everything, so they end up requesting that all other daemons are written as
systemd plugins[^5].

However, despite this and despite the flame wars it has caused throughout the
open source communities, and the endless attempts to [boycott][boycott] it,
systemd has already won. Red Hat Enterprise Linux now uses it; Debian made it
the default init system for their next version[^6] and as a consequence, Ubuntu
is replacing Upstart with systemd; openSUSE and Arch have it enabled for quite
some time now. Basically every major GNU/Linux distribution is now using
it[^7].

At the end of the day, systemd has won by being integrated into the democratic
ecosystem that is GNU/Linux. As much as I hate PulseAudio and as much as I
don't like Poettering, I see that distribution developers and maintainers seem
to desperately need it, although I must confess I don't really know why.
Either way, compare [this][boycott]:

> systemd doesn't even know what the fuck it wants to be. It is variously
> referred to as a "system daemon" or a "basic userspace building block to make
> an OS from", both of which are highly ambiguous. [...] Ironically, despite
> aiming to standardize Linux distributions, it itself has no clear standard,
> and is perpetually rolling.

to [this][stateless]:

> Verifiable Systems are closely related to stateless systems: if the
> underlying storage technology can cryptographically ensure that the
> vendor-supplied OS is trusted and in a consistent state, then it must be made
> sure that `/etc` or `/var` are either included in the OS image, or simply
> unnecessary for booting.

and [this][linux-systems]. Some of the stuff there might be downright weird or
unrealistic or bullshit, but other than that, these guys (especially
Poettering) have a damn good idea what they want to do and where they're going,
unlike many other free software, open source projects.

And now's one of those times when such a clear vision makes all the difference.

[^1]: That is, it's "imperative" instead of "declarative". Does this matter to
the average guy? I haven't the vaguest idea, to be honest.

[^2]: Some people don't consider software engineering a science, that's why.
But I guess it would be fairer to call them "principles", wouldn't it?

[^3]: One does not simply integrate components for the sake of "integration".
There are good reasons to have isolation and well-established communication
protocols between software components: for example if I want to build my own
udev or cron or you-name-it, systemd won't let me do that, because it
"integrates". Well, fuck that.

[^4]: And guess what; for system software, systemd has [a shitload of
bugs][bugs]. This is just not acceptable for production. Not. Acceptable. Ever.

[^5]: That's what "having systemd as a dependency" really means, no matter how
they try to sugarcoat it.

[^6]: Jessie, at the time of writing.

[^7]: Well, except Slackware.

[init]: https://en.wikipedia.org/wiki/Init
[unix]: http://cm.bell-labs.com/cm/cs/upe/
[bugs]: https://bugs.debian.org/cgi-bin/pkgreport.cgi?pkg=systemd;dist=unstable
[boycott]: http://boycottsystemd.org/
[stateless]: http://0pointer.net/blog/projects/stateless.html
[linux-systems]: http://0pointer.net/blog/revisiting-how-we-put-together-linux-systems.html
