---
postid: 02d
title: LinuxCon Europe 2014
date: November 8, 2014
author: Lucian Mogoșanu
tags: in the flesh, tech
---

As a change of scenery, I spent most of the 12th-18th October week in
Düsseldorf, Germany, at the [LinuxCon Europe][1] conference held at Messe
Congress Center. Since I'm not into this kind of (rather tiresome) experiences
and I don't do them very often, I think it would be very useful to write about
a part of what I've seen there, as I don't think I have the time nor the space
to cover absolutely everything.

The time I spent there was unfortunately pretty short: I arrived in Düsseldorf
on Sunday and left on Thursday, which means I barely got to see a few parts of
the town. I spent most of the time at the conference, where the organizers
attempted to pack a shitload of smaller events into just three days. This is,
from what I've heard, not uncommon, it's like the whole thing is designed to
turn you into a zombie as you try to face the fatigue, leaving you with little
time to do anything else but go to sleep, waiting for tomorrow's even more
interesting presentations. That aside, I'll share my thoughts on the conference
itself and on my overall experience with Germany so far.

## The conference

Leaving aside the more "meta" keynotes, LinuxCon in fact consisted of three
conferences, namely the main track (LinuxCon), CloudOpen and Embedded Linux
Conference. The "Cloud" aspect of it was in fact very widely spoken about, both
in the presentations and at the booths, as many providers, either of distros or
of other solutions, focused on the large-scale stuff. This honestly didn't
interest me very much, so most of the presentations I've been to were from ELC.
I'll give a very brief summary of the most interesting stuff that I've seen.

The first non-keynote presentation I've been to was Ron Birkett's [Enhancing
Real-time Capabilities with the PRU][2]. Although mostly a marketing
presentation, the talk gave me a really good insight into Texas Instruments'
orthodox approach to providing support for real-time applications. This makes a
lot of sense for applications where that microsecond (or less than that) really
matters, so you don't want caches and pipelines and other such nasty stuff to
interfere with what you're doing. As someone who's looking into running
real-time stuff and Linux side by side, I found the presentation really, really
interesting.

The second interesting presentation, this time not so marketing-related, was
Dave Anders' [ARM vs x86][3]. Despite what the title suggests, the talk was
less focused on the architectures themselves and more on the difference between
and the pros and cons of ARM and x86 platforms and development boards and
intellectual property producers, manufacturers and so on and so forth. If
you've worked with ARM in the past and wonder whether you should give an
x86-based environment a try, then you'll find this interesting. Similarly, if
you've worked with x86 stuff in the past and wonder whether you should use the
same architecture in the embedded world, you should certainly take a look at
the slides if you haven't been there.

At the beginning of the second day I've had the pleasure of watching Jono
Bacon's [Building Exponential Communities][4] presentation. I've been reading
Bacon's stuff since he was with Ubuntu, and despite the fact that he's not
technically-oriented, I really enjoyed the talk and found many similarities
between the problems he described and the ones that I often face in the (way
smaller) communities that I'm involved in.

Also in the second day, Brendan Gregg from Netflix gave a talk on [Linux
Performance Tools][5]. Although the approach of his presentation might have
come as "too high-level" for some, I found the extensive overview to be very
enlightening. To my shame, I haven't used ftrace or sysdig or pcstat before, in
scenarios when I would have found them possibly helpful. Indeed, his Linux
Performance page is now a reference in terms of performance analysis of Linux
subsystems.

In the same day, Karim Yaghmour, the guy who wrote the Embedded Android book,
talked about the ins and outs of [Android Security][6]. Although I'm not an
Android programmer and I'm only vaguely familiar with its architecture, I'm
well aware of how Android relies on not having root in order to provide
security; also, of how it relies on TrustZone for some of the more dubious
stuff, and how this causes problems even for some of the legitimate system
programmers. The parts about the lack of security features in Binder and the
otherwise useful pain in the ass that is SELinux were however mostly news to
me.

I had heard of [Jailhouse][7] before watching [Jan Kiszka][8]'s talk on it.
Much to my surprise, the guys at Siemens that are working into getting
Jailhouse up and running are using a very pragmatic approach: Jailhouse doesn't
really have a scheduler, so it simply dedicates processors for real-time tasks.
This should, at least in theory, make it much easier to get a certification,
which sounds like a much more realistic goal than that envisioned by some of
the other embedded hypervisors out there, say, the "exotic" stuff that are the
L4-based ones.

Of the other technical presentation, I'll only remind [Porting Linux to a New
Architecture][9], [rtmux][10] and [Mastering the DMA and IOMMU APIs][11], plus
Josh Triplett's [Linux Kernel Tinification][12], which I missed. Other than
that, the most interesting stuff from the third day were the opening and
closing sessions.

Torvalds' keynote discussion was fun to watch, although the Linus Torvalds I've
seen was very different from the throat-cutting Linus Torvalds from LKML.
Clearly, the guy is a technical guru who now has an enormous marketing pressure
on him, so he spends most of his time resisting that pressure, just for the
sake of keeping the Linux tree clean and neutral. [The talk][13], moderated by
Dirk Hohndel received a lot of publicity over Linus' statement that he regrets
some of the harsh language he's been using in the past; for his sake, I hope he
reconsiders that, because yes, no matter how political incorrect this might be,
being harsh is an integral part of running such a huge project, and no, project
management isn't a democracy.

There was also the closing game, but I'll pass describing this particular event
for the sake of brevity.

Bottom line, the conference was interesting, informative and gave me a good
insight on the "trends" and whatnot. I don't have the space to write about the
booths, but I've watched BMW's PandaBoard/Wayland demo, and I've also watched
[prpl][14]'s PowerVR demo. The attendees were mostly from corporations and
smaller companies and only a small number of people came from universities or
research institutes.

## Düsseldorf, Germany et al.

Despite this being my first time visiting Germany, I've found the view and
atmosphere to be somehow familiar, which is pretty weird, considering that I
live in the Bucharest shithole that most sane people are running away from. For
one, Düsseldorf is a big town, but not at all agitated. I was accommodated
quite near the city's center, in a multicultural zone consisting of Chinese and
Turkish restaurants, along with a few of my Romanian friends. Interestingly
enough, we were about fifteen Romanians at LinuxCon, most of us having some tie
or another to UPB, although we've met a couple of people coming from Cluj.

The best thing in Düsseldorf, except the beer, of course, is the orderliness.
Walking through Altstat, I've had the chance to see the people carrying on with
their lives, running, walking, going to the opera house and so on. In
contradiction to Romanians' arrogant assumption that Romanian women are the
most beautiful beings in the whole wide Universe, Germany has some really cute
girls, although it also has some damn ugly women, so there, nothing new here.
Germans are pretty boring until you get to interact with them, when they're
either your best friends, or arrogant enough so that you'd give them a punch
straight in the fucking nose. However they are, they're keeping their public
places clean, a fact which I wholeheartedly appreciate.

The worst thing in Germany is without doubt the food. Sorry guys, I'm pretty
sure you enjoy your wursts and schnitzels and overly salted and condimented
french fries there in the bubble you're living in, but really, go taste some
Spanish, Italian, Bulgarian and Romanian food, you'll see what I mean. The
Türks on Graf-Adolf-Straße had decent kebaps, but even those are nothing
compared to the stuff in Bucharest's old center.

All in all, a nice experience, although I don't think I'm doing this again
until next year. I hear they're planning to do the next one in Dublin. We'll
see, I guess.

[1]: http://events.linuxfoundation.org/events/linuxcon-europej
[2]: http://events.linuxfoundation.org/sites/events/files/slides/Enhancing%20RT%20Capabilities%20with%20the%20PRU%20final.pdf 
[3]: http://events.linuxfoundation.org/sites/events/files/slides/elce-x86-arm-2014.pdf
[4]: https://www.youtube.com/watch?v=velMxS4iA-0
[5]: http://www.brendangregg.com/linuxperf.html
[6]: http://events.linuxfoundation.org/sites/events/files/slides/android-security-141014.pdf
[7]: http://lwn.net/Articles/574274/
[8]: http://events.linuxfoundation.org/sites/events/files/lcjp13_kiszka.pdf
[9]: http://events.linuxfoundation.org/sites/events/files/slides/Rybczynska_Porting_Linux_to_a_new_architecture_ELC2014.pdf
[10]: http://events.linuxfoundation.org/sites/events/files/slides/rtmux_1.pdf
[11]: http://events.linuxfoundation.org/sites/events/files/slides/20140429-dma.pdf
[12]: http://events.linuxfoundation.org/sites/events/files/slides/tiny.pdf
[13]: https://www.youtube.com/watch?v=8EUuaY6rh4o
[14]: http://www.imgtec.com/prpl/
