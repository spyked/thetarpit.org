---
postid: 009
title: ROSEdu Haskell workshop, first edition
author: Lucian Mogoșanu
date: August 15, 2013
tags: in the flesh
---

Last month [ROSEdu][1] organized a set of workshops on various topics related
to the field of computer science, at the Faculty of Automatics and Computer
Science in [UPB][2]. I participated, along with Mihai Maruseac and Dan Șerban,
as a trainer and speaker at the Haskell workshop, since, as you might have
probably noticed from the Hakyll basis on which this blog rests, I'm very much
in love with the language.

<!--more-->

The Workshop lasted five days. Four of them were dedicated to specific subjects
approached mostly from a practical point of view, with some incursions into
theoretical concepts that couldn't be avoided. The last day consisted of a
short hackathon, illustrating that someone with little to no knowledge about
Haskell can in a short time come to contribute to a real-life application, be
it a simple, fun game or a more complex project such as Yesod.

In the first day, Mihai discussed Haskell basics: some history, functions,
lists, syntactic sugar, debugging and a full presentation on the importance of
types and in particular static typing. A few other highlights are Dan's awesome
talk on infinite lists and Mihai's presentations on GTK, diagrams and web. I
approached two subjects: xmonad window management and static site generation
using Hakyll.

Things went ok, generally speaking. Some of the students had already taken the
functional programming class taught at the faculty, so now they had the
occasion of getting a taste of the "real-world" Haskell and doing a bit more
than implementing classical algorithms. Students with more experience in
software development saw for example the advantages of the QuickCheck approach
to software testing and the disadvantages of issues generated by Cabal's
dependency system.

Since this was the first edition, there were also a lot of bad aspects. We had
trouble doing a last-moment deployment of the virtual machine on the computers
in the lab. Even so, a couple or three Yesod-related packages were missing, so
the students had to experience dependency hell firsthand, which was anything
but pleasant. These problems were only made worse by the fact that I wasn't
speaking loudly enough[^1].

As far as I could tell from my experience with the workshop, teaching Haskell
"from N00b to Real World Programmer" is a real challenge in itself, and an
achievable one I might add[^2]. The ordering of the subjects wasn't quite right
and maybe some might need to be removed altogether. A more focused workshop
might also do the trick; for example, I noticed that we haven't talked nearly
enough about Haskell web technologies such as Fay, Happstack (as an alternative
approach to Warp/Yesod) or [threepenny][3].

That being said, I hope to see *you* there on the next edition!

[^1]: It's an issue I've been struggling with for some time now, but alas, I
haven't done any major improvements over the years.
[^2]: I don't know if this is applicable to other languages. Ironically,
seasoned C or Java programmers are the ones that complain the most about the
supposed difficulties of functional programming.

[1]: http://workshop.rosedu.org/2013/
[2]: http://www.upb.ro/
[3]: http://apfelmus.nfshost.com/blog/2013/07/21-threepenny-gui-0-1.html
