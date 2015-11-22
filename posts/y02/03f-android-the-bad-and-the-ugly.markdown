---
postid: 03f
title: Android, the bad and the ugly
date: November 22, 2015
author: Lucian Mogoșanu
tags: tech
---

The field of operating systems engineering has been completely stuck in a rut
in the last few decades: kernels [aren't what they mean][os-design], Unix is
*the* standard -- and mostly rightfully so -- and only few people[^1] think
beyond the current engineering mess and try to bring something on the table to
solve actual real problems that should be solved by, oh, I don't know,
yesterday.

Android in particular is a half-baked idea initially designed for mobile
phones and later extended for tablets, phablets and other devices for
idiots[^2]. The fundamental idea itself is great: an operating system meant to
run perpetually and provide immediate accessibility to whomever wants to use
it, as e.g. you may need to be able to answer that phone call right now and
you need to read that important mail, yep, you guessed it, right now[^3]. Its
actual design and implementation are however bad, to say the least, and unlike
other open source software such as, say, Linux, I don't see it growing and
changing organically in the following years, unless Google decide to give up
control over it; but anyway, less prophecy and more facts.

Note that this post is the result of years of usage and only because it
doesn't cover the good parts, it doesn't mean that there are none. No
improvement ever arised from gratuitous praise, however, so if you see fit to
apply the same critique to other operating systems, mobile or otherwise, feel
free.

## The usage model

As it was designed for memory-constrained mobile devices, Android has a few
neat doohickeys implemented.

Firstly, only one "activity", i.e. an application or part of it, may be run at
a given time. Secondly, fast application switching is done by keeping as much
of it and as many "activities" as possible in RAM. Thirdly, the kernel
implements a "low-memory killer" (essentially a sort of garbage collector
combined with a caching mechanism) that kills the least recently used
"activities" when the system runs out of free memory. So the reasoning behind
this scheme is simple: you start as many applications as you like, and the ones
you used most recently will actually be kept in memory; the others may end up
being killed, but everything should be properly saved if they implement the
save/restore functionality exposed by the operating system interface[^4].

The issue with this model is that it doesn't take into account that the user
will often end up wanting to use many applications over a small period of
time. And while I agree that the user shouldn't be bugged with memory
management issues, killing applications like that is a *major* source of
non-determinism. Say, you recently ran a game which uses a lot of memory; then
you run your feed reader and in turn use it to call the browser "activity" to
read a post; then, after five minutes or so you finish reading, but you find
out that for some reason the operating system decided to kill the feed reader
"activity", which is then returned to its initial state, not the one it was
supposed to be in after reading. Frustrating, isn't it? And all this without
even mentioning the performance issues caused by reaping memory and re-starting
the application.

Oh, and heavens forbid you should ever try to listen to music on Youtube and
use the browser at the same time. No, this won't work, and "implementing it as
a Service" isn't a solution, because in a sane system not all background
applications are services. A service is a service, not any application running
in background, but y'know, actually running and doing useful stuff.

Long story short, if you want me to use your system for general purpose
applications, make it act like a general-purpose system, not some MS-DOS crap
on a 80286.

## The architecture

Despite the fact that it was designed for memory-constrained mobile devices,
Android's architecture is largely distributed: most of the operating system
runs on top of the Linux kernel, and comprises a run time component coming
mostly from Java, but it's also made up of various other types of system
components, such as "services", "managers" and a plethora of other software
handling everything from displaying the current application to managing sound,
notifications and other system settings.

This makes Android a very ambitious project, more so that it's been ported on
a shitload of hardware platforms. At the same time, it makes it a proverbial
hell of maintenance, compiling and interworking, resulting in zero benefit for
the end user. Yes, all "modern software" is piled on layers upon layers of
complexity, but this does not make Android a model for how software
development is done.

This so-called hell is well reflected in Android's maintenance cycle: new
mobile devices get the newest version, while old devices are left to rot,
although that new version of Android should -- at least in theory -- work on
your crappy old device. This isn't (only) an evil market gimmick on the
vendors' side; no, the fact is, testing costs, and the pressure of delivering
even the small yet critical security patch to a million devices is so costly
that your average corporation can't afford the trouble. And you lose.

## The protection model

I'm only including this because security is such a big topic nowadays; so,
first, let's get one thing straight: Android doesn't have a protection
model. Yes, applications are sandboxed and no, you can't exploit Android
applications the way you used to exploit the old ones[^5], but as far as
security goes this doesn't really mean anything.

Android applications are subject to this system where the developer uses a
so-called "manifest"[^6] to describe what permissions the application needs in
order to use various components, e.g. the accelerometer, the file system, the
phone dialer and so on. When the user installs or updates the application, and
exactly before that happens, they're greeted with the list of permissions
required. At this point, the user has the option to continue installing the
application or cancel the process; so, what will the user select in most
cases? Take a wild guess.

This approach has two problems. Firstly, you can't disable permissions
selectively[^7], so this "all or nothing" strategy is bothersome if you want to
e.g. use Facebook without letting it send SMSs on your behalf. Secondly,
despite efforts from the Android developers' part, permissions are not
granular: "access to the file system" doesn't say anything about which files
are accessible; making calls or downloading files doesn't impose any quotas, so
you can download a 200KB application that then eats through your entire data
plan in five minutes; I won't even go into the web access permissions which
come as a complete privacy killer, nor into the wakelock acquision which can
eat your phone's battery without you even noticing, but you get the general
idea. Basically, all you're left with is trusting the application developers to
not be malicious or utter incompetents.

Additionally, there's the issue that once an application gets some permission,
that permission can't be revoked or blocked without uninstalling. All the
application needs to do is send an "intent" that it wants to use this or that
and the system willingly gives it, just like that, without asking the user[^8].
Surely, there are lots of scenarios where this makes sense, but there are
others where it doesn't, and the user once again loses. Possibly even money,
the real kind.

If you've been reading this properly, by now you should be convinced that the
"Android protection model" is a sham. It's a model alright, but it has nothing
to do with protection nor security. Probably the only good security-related
thing that ever happened to Android was the SELinux integration.

## Conclusion

If I were a good man, I would write another article with possible solutions and
alternatives to the current issues with Android. Fortunately for me, I'm not.
However I can say that whatever change will occur must come from a rethought
and redesigned operating system, be it for mobile or desktop.

Meanwhile the list could go on. I haven't even touched on the general
usability issues, as I haven't said anything about power management or the bad
marketing associated with Android phones, or smartphones in general. You
probably know about some of those already; my post will only stand as a
reminder of how mobile operating systems used to look back in 2015.

At the end of the day, it doesn't hurt to take a closer look at what Google,
Samsung, HTC and all the others are selling you. And by the looks of it,
Apple are doing the same.

[^1]: You see, no one makes machines, be they physical or purely theoretical,
only for the sake of making machines. The sole purpose of the machines'
existence is the well-being of people and not the other way around; or, in
other words, people matter, machines don't, unless they're useful to us
somehow.

[^2]: People in the West are clinging so much to the idea that everyone and
their dog should know how to code, but they sell devices without a proper
keyboard. Well, no, sorry, that doesn't work. Tell me when's the last time
some American company came up with a decent laptop.

[^3]: I'd like to see sociologists struggling to measure the effects this has
on people's lives. But I'm digressing; fast boot times are important for those
of us who don't drink coffee.

[^4]: Which they very often don't, at least not properly. This is a major flaw
in Android's design, although the guys who designed this might think
otherwise. The thing is, you don't usually trust the application to save and
restore its own state, otherwise bad stuff may, or rather most probably will
happen to it. If nothing else, this makes application programming more
difficult, as opposed to what the guys at Google are claiming.

[^5]: Oh wait, [you can][privilege-escalation]. Nevermind. But for the record,
you almost always can, because most programmers are terribly lousy.

[^6]: Essentially a spec file for requesting resources from the operating
system. Not such a bad idea actually.

[^7]: They say that the next iteration of Android, Marshmallow. will (finally)
support this, though, and it will work even for "legacy" applications. I'm
pretty sure this will come at some cost, we're just not aware of it yet. All
engineering is trade-off, and software engineering more so, especially when
done for the purpose of backward compatibility.

[^8]: Oh, and these "manifests", "intents" and whatnot can be hacked, at least
in theory. It all reduces to editing that spec file, and there, you have
whatever it is that your "malicious app" wanted.

[os-design]: /posts/y01/03a-the-linguistic-barrier-of-os-design.html
[privilege-escalation]: http://thehackernews.com/2014/11/billions-of-android-devices-vulnerable.html
