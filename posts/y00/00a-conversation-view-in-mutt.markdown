---
postid: 00a
title: Conversation view in Mutt
author: Lucian Mogoșanu
date: August 18, 2013
tags: tech
---

My current `.muttrc` bases itself upon a plethora of web articles that touch
this subject. I won't link any of them here, they are simply too many. Needless
to say, a simple search on Mutt will send you down the path of proper
configuration of this wonderful e-mail client, either through the official
documentation or third-party sources such as this post.

One feature which made Gmail such a popular application and hindered my
migration to Mutt a few years ago, was the so-called "conversation view", i.e.
the ability to group mail-reply sequences into single linear threads. Mutt has
in fact a better feature called "threaded view". It is better in that it
organizes a given discussion as a tree, which gives the user a much clearer
view on who responded to whom, unlike Gmail, which, as I said, only has linear
threads.

<!--more-->

To enable threads in Mutt, one must insert the following line in `.muttrc`:

~~~~
set sort = 'threads'
~~~~

or

~~~~
set sort = 'reverse-threads'
~~~~

to make it resemble Gmail's most-recent-first order.

Since threading is enabled, sorting is now done on two levels: one within the
thread, and the other between threads. The `sort_aux` option controls how
sorting is done between discussions and is documented [in the manual][1].
Basically, to obtain something very similar to Gmail, I use:

~~~~
set sort = 'threads'
set sort_aux = 'reverse-last-date-received'
~~~~

However, conversations still aren't *that* clearly delimited. Mutt still
displays all the mails in the folder, which is a real nightmare for heavy
inboxes[^1]. And we can't, as far as I know, "squeeze" e-mails into a single
conversation that shows as an item in the inbox. What we can do, however, is
filter all the e-mails in a conversation using the `limit` function. What we
want to do is make Mutt show us only the current conversation in the index and
pager modes.

The following set of steps describes a simple, yet time-consuming way to
achieve this:

1. Tag all the mails in the current conversation: `esc` followed by `t`
2. [Apply][2] `limit` to tagged mails: `;` followed by `l`
3. Limit to [tagged][3] e-mails: `~T` followed by `enter`
4. Untag all the mails in the current conversation: `esc` followed by `t`

The filter can be reset in a similar manner:

1. Apply `limit`: `l`
2. Limit to all e-mails: `all` followed by `enter`

Unfortunately, these steps can be a hassle to apply even for experimented
users, since they really are time consuming, although not too hard to
memorize.  Fortunately, Mutt can be extended through macros, which were
designed specifically for repetitive actions. Thus by pasting the following two
lines in `.muttrc`:

~~~~
macro index,pager ut <tag-thread><limit>~T<enter><tag-thread> "show only current thread"
macro index,pager ua <limit>all<enter> "show everything"
~~~~

we can run the two commands by pressing `u` followed by `t` and `u` followed by
`a` respectively. I've chosen `u` as a prefix key since it's not used for any
default actions. Feel free to suggest a more meaningful combination.

Now Mutt is one step closer to the Gmail interface, while remaining more
responsive and less memory-consuming, not to mention the CLI/TUI minimalistic
awesomeness.

[^1]: I don't know why anyone would keep more than 50 mails in the inbox, but
it's happened to me. There are times when writing e-mails is so much more
pressing than managing them, and that's when the inbox suddenly starts
gathering 100+ messages. Folders and automatic filtering help prioritize, but
for some reason Mutt doesn't encourage using folders. I've been using
mutt-patched for quite some time now and still haven't managed to use them
properly.

[1]: http://www.mutt.org/doc/manual/manual-6.html#sort_aux
[2]: http://www.mutt.org/doc/manual/manual-6.html#ss6.4
[3]: http://www.mutt.org/doc/manual/manual-4.html#ss4.2
