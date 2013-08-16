---
postid: 002
title: The Tar Pit: technicalities
excerpt: A dive into technical aspects of The Tar Pit.
author: Lucian Mogoșanu
date: July 27, 2013
tags: asphalt, tech
---

<p style="text-align: right">
*[So I’ve erased myself, replaced my mind, it's a clean slate][1]*</p>

I would argue that the tools used to create some arbitrary kind of art, or
craft, are completely irrelevant. The argument is supported by past pieces of
art, some of which were made in very rudimentary conditions, a fact which at
the same time doesn't make them any less "artistic" than newer, more
"sophisticated" creations. Some would even argue the opposite: that earlier art
has more personality, since it involved more sweat and blood. This is of
course bullshit, as there are many handcrafted works that look dull[^1] and
some chaotic geometric shapes that can be described purely mathematically[^2].

That is, tools are of little importance to the consumer, while they can make a
big difference for the producer. Some hundreds of years ago people were writing
using quill pens and parchments, while more recently Douglas Adams wrote on an
Apple computer. While this makes no difference whatsoever to the reader, they
helped the writers be more or less productive, given that quills and parchments
are easier to use than clay tablets, although significantly slower than your
modern keyboard. Sure, it's not that pencils are in any way "inferior" to
computers; they're just different tools serving different purposes.

<!--more-->

## The eternal issues of Content Management Systems

About nine months ago or so I felt that Wordpress was no longer the right tool
for me. I had already known that it had its problems and I had used various
palliatives that kind of worked, only not in the way I wanted.

One of the smaller problems of Wordpress was its inner workings, that require a
fully working, fully configured LAMP[^3] environment. There's not much to say
about that, this kind of setup is now a de facto standard on the web. However,
the really small stuff killed me. For example, pingbacks mysteriously stopped
working without me even noticing once I changed the router in my internal
network. The new router didn't support NAT loopback, while Wordpress was
continuously making requests to the public IP address, making it impossible to
reach itself[^4]. I solved the problem later by doing some DNS voodoo, but the
fact remains that I was desperate about trying to fix a system that doesn't
work reliably anyway[^5].

Then there was that issue of spam. For a blog that got a comment per month or
less, the old blog™ received a shitload of spam, so much that the (non-premium)
Akismet queue couldn't handle it. This was frustrating me, since I was now
spending more time doing moderation and checking for false positives than
doing, you know, the important stuff.

Finally, all these problems led to performance issues. After attempting some
holistic server-side optimizations, I had to get a new server to ramp up
loading time. I also tried some stricter security measures such as IP banning,
but again, this incurred a lot of overhead from my side, and mind you, I can't
say I find the idea of being a sysadmin too attractive.

## The zen of static site generation

About nine months ago, I realized that a static blog would solve all these
problems and pose some others. On one hand, a static site loads fast, has a
simpler design, which makes it a lot easier to configure and customize, and it
eliminates comment spam by design. Since I'm into Haskell, Hakyll seemed like a
good idea, even though there are other pretty good alternatives out there.

On the other hand comments, I admit, are kind of a big issue. For a while, I
looked into third party commenting systems, or writing my own, or even using
the one from Wordpress, but I realized this would bring back the spam
nightmares I had previously had with it. I also thought about proprietary
alternatives such as Disqus, but Disqus is a service with terms that I don't
necessarily agree with. So no, I wouldn't have them owning the comments of my
readers.

Therefore, I have given up comments altogether. Once the blog has a contact
page, you'll have the option of commenting on my stuff by sending me an e-mail
or a message on whatever social network I'm on. Moreover, feel free to link my
posts to Reddit, Facebook, Twitter and whatever social network you're on, and
drop me an e-mail if you feel like I should give my input. Other than that, I
don't really feel like turning back to comment moderation, I think that I
should focus on writing and not much more.

## Die Sprache

I'll end this post by mentioning that I deliberately chose English as the main
language[^6] for The Tar Pit. I'm not a native, nor a particularly good English
speaker or writer, hence this gives me the occasion to improve my skills and
evolve, which was pretty much [my motivation][3] from the beginning.

I am also hoping that, being written in one of the most widely spoken languages
on the web, the blog's more obscure content will reach a bigger audience. I'm
well aware that this could change. Maybe Simplified Chinese will become the new
hot trend in five years from now, which means I'll just have to learn it and
use it in writing.

*As for why The Tar Pit, stay tuned, you'll find out soon. Really soon.*

[^1]: There are those that call themselves "slow artists", who find great
pleasure in spending tens of hours in making intricate, beautiful patterns,
which can nowadays be reproduced by a computer in a matter of seconds. Both are
awfully symmetric, both lack personality, thus rendering the whole "automatic
versus handmade" debate useless.

[^2]: Fractals, dynamical systems in general.

[^3]: Linux, Apache, MySQL and PHP

[^4]: I documented this on [my previous blog][2] (in Romanian).

[^5]: It's not that pingbacks are not reliable by themselves. It's that the
XML-RPC protocol, or rather its implementation, is crappy. I agree that in
theory pingbacks are a really cool idea meant to fire up discussions, but in
practice they never seem to work quite right.

[^6]: Maybe not the only one. I don't know, I guess we'll cross that bridge
when we come to it.

[1]: https://www.youtube.com/watch?v=BdAeqtw3KeQ
[2]: http://lucian.mogosanu.ro/bricks/de-ce-nat-ul-e-o-idee-proasta "de ce nat-ul e o idee proastă"
[3]: /posts/y00/001-introduction.html "The Tar Pit: an introduction"
