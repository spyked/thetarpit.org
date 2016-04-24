---
postid: '00e'
title: Cloud software is unreliable
author: Lucian Mogoșanu
excerpt: A weak argument.
date: September 12, 2013
tags: cogitatio, tech
---

In this post I will argue that the so-called "Cloud" computer programs are
inherently unreliable. I will assume that the reader knows what "Cloud
computing" means: essentially a marketing buzzword referring to network-based
services oferred by a third-party. The term "unreliable" is however not that
much of a buzzword, and therefore I will spend a few paragraphs describing
it.

## Reliability, definitions

In short, reliability is a measure of whether stuff works at a given point or
over a given period of time. By "stuff" I mean systems, in particular computer
systems, the entire thing, both hardware and software. By "works" (which is the
opposite of "fails", by the way) I mean that it performs a particular task that
was specified beforehand by the user in non-ambiguous terms. For example, I
want some software to tell me the weather forecast for the next couple of days.
If said software gives me a result, then we say it's reliable, and vice-versa,
if it fails to give a result then it's unreliable. Ideally, the software should
also give a *good* result, but we don't know whether the result is good or bad
unless the program has been consistently giving bad forecasts over time. So
good/bad results are often tricky[^1], and we don't want to complicate things
too much.

[Wikipedia][1][^2] also gives a brief definition, actually a set of
definitions, of reliability:

> Reliability is *theoretically* defined as the probability of failure, the
> frequency of failures, or in terms of availability, a probability derived
> from reliability and maintainability. 

The probabilistical approach is interesting: if a thing has a high probability
of failing, then it's unreliable. Availability is more used in practice,
especially for server uptime: if a service works properly 99.9999% of the time
in a year, then it is highly available, or in other words, pretty reliable.
Remember that software is different from hardware, in that it doesn't degrade
because of physics, but rather because of the sheer stupidity of
developers[^3].

Now that we've etablished possible definitions of reliability, let's give some
examples illustrating the unreliability of Cloud services.

## Examples of Cloud unreliability

**Scenario 1**: The GitHub project. GitHub is one of my favourite Cloud
providers, which is why I'm giving it as an example and keeping it in mind
myself. So, you're the CEO of a company, working for an important software
project. It's been decided that all development files will be hosted on a
private GitHub repository. You're one day before deadline, the clients have
their eyes on you, and you know you're gonna lose lots of dollars if this
fails. By some weird occurence, GitHub servers fail. Chaos ensues.

But well, the reader might argue, this could have happened as well on a
privately hosted server. And I will answer aye, indeed, it could have. Only
that if it happened on a private server, someone could be held accountable for
the failure: the sysadmin, some hacker, well, *some* entity. In the case of
GitHub, basically no one can be held accountable. Certainly not GitHub, it was
stated in their ToS last time I looked.

**Scenario 2**: Google's supercalifragilistic mailing service. I use this one
as well and I hate myself for it. The main concern here is not of availability,
given that Google seem to be deep there in the energy sector, among others. The
problem lies in security, more specifically in the fact that some 14-year old
kid can easily break into my account if for example Google decide to use crappy
certificates at some point in time. In fact, Computer Security 101 tells us
pretty clear that the security risk doesn't come from known threats, but from
vulnerabilities that haven't been discovered yet.

That can be easily generalized to the entire Cloud computing environment.
Leaving aside NSA snooping issues that can easily break your business[^4] if
you're doing stuff that's not approved by the US government, the subject of
Cloud computing security is a bit of a nasty bugger here. There have been some
successful attempts to drive away crackers from virtual machines running in the
Cloud, but the problem isn't this, it's that the unknown is so big. I'd link to
some literature on the subject, only I haven't seen any last time I looked. If
that doesn't scare you, then you're just ignorant. If by any chance you know
more than I do, please link that in an e-mail.

Plus, I have to mention the NSA snooping issues again. We're all ignorant about
that, which is at least as scary.

**Scenario 3**: The Google Reader. I'm sorry I have to blurt it out on Google
like that, but they're the company that have recently had the most cases of
Cloud software going down suddenly. These cases show well that Cloud companies
don't give a damn about their customers. They want to make money, which is ok
for any business, that is, until making money starts becoming contrary to
customers' interests.

So you're a Google enthusiast. You've noticed the takedown of Google Notebook,
Google Translate API etc. Finally, after all these years, they also take down
Google Reader. What now? Are you going to move to yet another web-based RSS
reader that's going to close sooner or later? Good for you.

Cloud software is thus inherently unreliable due to being inherently closed and
untrustable, unless you can get the code, compile it and run your own instance.
Google could have removed sensitive parts of their Reader and open sourced it,
but I suppose they really did just not give even the smallest damn.

## Conclusion

The examples above are not strong, in the sense that they don't describe
systems which should be necessarily dependable. Google Reader closed and the
world moved on, people can live with having their [insert Cloud service here]
accounts hacked and downtimes are ok as long as they don't cause permanent
damage such as loss of data. Keeping all (and by all I mean *all*) your
personal files exclusively in the Cloud is a big issue though, and I hope no
sane individual does that, for their own sake.

Some political-economical pros and cons could also be discussed. For example,
many people insist on comparing the Cloud (ex-"Grid") with the electrical grid.
Surely, you're paying your electricity company for energy and your ISP for
Internet, so why wouldn't you pay your Cloud provider for hard-disk space, an
office suite, a book or an MMORPG? Besides implications related to personal
rights and freedoms[^5], the ironical thing is that small companies and
individuals are trying to stick it to the man and move away from the
centralized energy distribution model by installing small windmills and/or
solar panes. And that's pretty much the future, maybe not entirely, but at
least partially. Well, commercial computing seems to be heading the opposite
way, putting way too much power in the hands of corporations. Don't believe me,
I'm nobody. Read [Schneier][3]'s point of view.

Overly-centralized systems lack stability. Cloud services are unreliable. This
seems to somehow fit nicely into the big picture. ▪

[^1]: Sometimes depending on the user.
[^2]: For all you science purists out there, I am well aware that Wikipedia is
not a particularly good source of information. However, the definition is
pretty good. I've learned it myself in faculty, I *know* it's good. Don't
believe me? Then go find it for yourself in an engineering book, just make sure
you don't pester me about it, mkay?
[^3]: What I'm saying is that, theoretically, if a piece of software works at
version 1 and then it (partially or totally) stops working at version 2, then
that makes that piece of software pretty unreliable. Unfortunately, developers
often introduce bugs in their software for various reasons, but we can dumb
that down to sheer stupidity.

	Sure, we could look at it the other way and say that well, software is
	pretty damn complex, which it obviously is. But engineering stuff that you
	don't understand is indeed rather stupid, so the bridge-software analogy
	holds well in the field of software reliability. Tell that to the people
	who've died in the [Challenger disaster][2], I'm sure they'll agree with
	you. Oh wait, they can't, they're dead.

[^4]: And quite possibly *you*.
[^5]: No, you don't own your Amazon e-books, your Steam games and your Spotify
music. It sucks, doesn't it?

[1]: https://en.wikipedia.org/wiki/Reliability_engineering
[2]: https://en.wikipedia.org/wiki/Space_Shuttle_Challenger_disaster
[3]: https://www.schneier.com/essay-406.html
