---
postid: 02f
title: On usability, a case study
date: December 6, 2014
author: Lucian Mogoșanu
tags: tech
---

Given nowadays' popularity of the web, usability is, I suppose, still something
of a hot topic in the field of human-computer interaction. More than half a
decade since the first electronic computer, the concepts behind making our
computing devices usable are still largely left to exploration. But what is
"usable"? I will defer to my friend, [Merriam-Webster][merriam-webster]:

> us·able  
> 1: capable of being used  
> 2: convenient and practicable for use

So, is a hammer usable? Well, it is, in the sense that I can use it to drive
nails into pieces of wood. Is then a guitar usable? Well, it generally is, in
the sense that it allows me to make music; in particular, it might or might not
be, depending on the guitar's neck and the length and width of my fingers. So,
is the computer, a general-purpose device typically comprising a keyboard, a
mouse and a monitor as input/output tools, usable? It's hard to say, this
depends on what I want to do with it, on the operating system and the user
interface it implements and so on; if I intend to play a game, maybe I'm better
off using a gamepad or some other type of specialized controller[^1].

Getting back to the World Wide Web, in the last few decades companies such as
Google have been pushing to move at least a part of their applications on the
web. JavaScript has become the most widely used programming language on the web
for exactly this purpose: the web had an untapped potential for improved
interaction from the very beginning, as semantic content can be easily
implemented on top of it using pages, hyperlinks and "rich text" elements.
JavaScript merely allows this content to be modified dynamically, allowing, for
example, the browser to change a section of a page when the user presses a
button, as opposed to reloading the entire page. Along with the great potential
for developing web applications, this has also opened a few more perverse
avenues for developers; for the sake of sticking to the subject, I won't go
into any details regarding this aspect.

I wish to present a comparative case study for the purpose of illustrating the
usability of web applications. I will dive into the bowels of one of the web's
most widely used applications, Gmail, comparing it with Mutt. I've been using
both of them extensively for at least one year now, so I am quite able to
distinguish between the pros and cons of both.

Firstly, I should mention that Gmail comes with many features in comparison to
Mutt. For example Mutt doesn't have filters and it doesn't offer any interface
for editing mail by itself; it doesn't have any support for built-in chat, nor
does it allow configuration for multiple accounts, since it doesn't really have
a well-defined concept of "accounts". Fortunately, that functionality can be
integrated using many third-party applications, which is why I will focus on
the basics, i.e. reading mail and making sense of the great e-mail organization
mess of which we are all aware.

One major advantage that Gmail has over all the other clients is that it
replaces folders with labels. This is compatible with the IMAP folder view, but
with the addition that you can have a single mail residing in multiple folders
(or under multiple labels, to use Gmail terminology) at the same time. This is
indeed very useful, mostly because you can keep an e-mail in the inbox *and* in
another folder simultaneously. However, Gmail's biggest and greatest advantage
is the search function, allowing anyone to find e-mails almost
instantaneously[^2].

Mutt on the other hand was created back in the 1990s, when folders weren't very
popular, so the focus of the main window is on the current folder and only
it[^3]. Mutt's main disadvantage is the steep learning curve: you have to sit a
few hours to [configure][mutt] it before obtaining a usable interface. After
you waste that time, however, the interface will be blazingly fast, albeit
keyboard-driven instead of mouse driven. This feature is so useful that it was
borrowed by Gmail's keyboard shortcut interface, whose documentation, in case
you're not aware, can be accessed using the question mark (`?`) key.

Regarding composing and answering to mails, I mentioned earlier that Mutt
doesn't have a built-in editor. Well, no, but it simply opens your system's
default text editor whenever you want to edit an e-mail. This hard separation
is, I believe, Mutt's greatest strength and Gmail's greatest weakness. Did you
ever open a draft in Gmail's big, shiny "composer", started writing, focusing
some other window, then re-focusing the "composer" window, pressing `enter` and
finding out that your draft was just sent? Well, that, dear reader, is the very
opposite of usability: an e-mail client should never, ever, **ever** send your
e-mail when you press `enter`, because that's one of the largest keys on your
keyboard and one of the most commonly used. Not to mention that when I write
e-mails, I want to write e-mails in that precise context, without any useless
clutter.

Mutt's greatest disadvantage is that it sucks. However, as its author
[mentions][mutt2], "All mail clients suck. This one just sucks less".

So, is Gmail usable? Mostly. Is Mutt usable? Not much more than the previously
mentioned client, but it does the same essential stuff at a much lower price.
At the end of the day we use whatever we feel comfortable with, regardless of
their usability. Or "usability".

[^1]: Although I personally never enjoyed using controllers to play games. The
mouse and the keyboard are the perfect interface for, say, a first person
shooter.

[^2]: Note that this is also partly a feature of e-mail being text-driven,
rather than HTML-driven or whatever nonsense "modern" "enterprise" e-mail tries
to push nowadays. HTML isn't usable in e-mail, because not everyone can or
wants to look at HTML, and not everyone wants cross-site scripting embedded as
a "feature" in e-mails. Also note that this is not a matter of preference,
despite how much your mileage may vary.

[^3]: Although certain forks come with support for sidebars.

[merriam-webster]: http://www.merriam-webster.com/dictionary/usability
[mutt]: /posts/y00/00a-conversation-view-in-mutt.html
[mutt2]: http://www.mutt.org/
