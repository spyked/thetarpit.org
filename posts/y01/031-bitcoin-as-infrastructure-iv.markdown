---
postid: '031'
title: Bitcoin as infrastructure [iv]
date: December 26, 2014
author: Lucian Mogoșanu
tags: tech
---

Also read: [Part I][1], [Part II][2], [Part III][3].

## Part IV: Examples and conclusion

While I've come to this idea of Bitcoin-as-infrastructure on my very own more
than half a year ago, I very much doubt it's a new one, and I doubt even more
that it was a new concept back then. In fact I had stumbled upon examples
illustrating it some time after finishing [the first part][5] of this series.
This only made me realize further that the possibilities involving Bitcoin are
still largely left to exploration even now, five years after Bitcoin's
inception and the now famous [Bitcoin paper][6].

In retrospect I believe I would have been much more inspired to call this
concept "blockchain as infrastructure". That's not to say that Bitcoin itself,
as a financial system, is not interesting; quite the opposite, in fact: while I
personally don't believe that bitcoins and Bitcoin are meant to remove existing
currencies, much like the Internet hasn't removed phones, for example, it is,
to say the least, disruptive and it will change the way we think about money,
payment, banking and so on. As I mentioned at the very beginning, I am not very
familiar with finance, but there are already services for betting[^12],
securities exchange[^13] and gaming[^14].

The blockchain, however, can be used for much more than transferring money. As
money are proof of wealth, one could in theory devise a blockchain-based system
for proof of other things, from authenticity of documents (which could in turn
be used for making digital contracts) to "proof of process", such as the idea
employed by [NotaryChains][10].

One of the early blockchain-based ideas that I've encountered was [twister][11],
a microblogging service inspired, as you might have already guessed, by
Twitter. Twister is in fact a hybrid system, using a blockchain for user
registration and authentication, and BitTorrent (especially its Distributed
Hash Table) for the distribution of actual messages. I doubt it's gained very
much momentum, but it's being [actively developed][12], which is a good sign,
if nothing else. There are other, more general, blockchain-based communication
protocols, such as [BitMessage][13], but they're even less popular at the
moment.

A favourite of mine is [DNSChain][14], a naming and public key infrastructure
system that claims too many features to list here; in particular, the security
features are very interesting: Man-In-The-Middle attacks are theoretically
unfeasible[^15] and practically impractical; the hierarchical Public Key
Infrastructure chain of trust is replaced with the blockchain; domain seizures
are limited to network resilience, and so on. I like the idea very much and I'm
very curious if they'll manage to deploy it.

There are many other such projects, providing either infrastructure (e.g.
[Bitcloud][15], [OpenLibernet][16]) or just a better interface to
blockchains/cryptocurrencies (e.g. [Bitcore][17]). Some are interesting, while
some are trying to achieve too much in my opinion. For example, [Ethereum][18]
looks like a very promising solution for application development, aiming to
create a programming language for this purpose. It might fail, but I'm fairly
sure that it won't be the first attempt, and if not this one, then some other
project will do things the right way.

At the very end I would like to restate the potential of Bitcoin, or the
blockchain, call it whatever you like, to become another layer in the backbone
of the current computing infrastructure. I prefer to see it as such, and I
strongly believe that it should be seen as such, because the possibilities
behind it are definitely worth exploring, discussing and implementing into
something better than what we have today. Time will eventually tell if I am
right, of course, but then again, that's not what matters.

[^12]: Such as [BitBet][7] and my personal favourite, [War of Life][8], which
unfortunately went down meanwhile.

[^13]: If you're involved in some way or another in Bitcoin, you must have
heard of [MPEx][9] by now.

[^14]: Those seem to be focused mostly on betting games, but using Bitcoin as
an in-game currency has real potential, since from a point of view bitcoins
aren't much different from Linden dollars or InterStellar Kredits, to name only
a few so-called "virtual currencies"

[^15]: If you run a node, which one wouldn't expect most people to do, I
suppose. The main idea is that if you keep a copy of the blockchain on your
hard drive, you'll never have to go through an external DNS provider, while
network resilience should guarantee that no one messes with everyone's domain
records.

[1]: /posts/y00/01f-bitcoin-as-infrastructure-i.html
[2]: /posts/y00/022-bitcoin-as-infrastructure-ii.html
[3]: /posts/y01/027-bitcoin-as-infrastructure-iii.html

[5]: /posts/y00/01f-bitcoin-as-infrastructure-i.html
[6]: https://bitcoin.org/bitcoin.pdf
[7]: http://bitbet.us/
[8]: https://btc.waroflife.com/
[9]: http://mpex.co/
[10]: https://github.com/NotaryChains/NotaryChainDocs
[11]: http://twister.net.co/
[12]: https://github.com/miguelfreitas/twister-core
[13]: https://bitmessage.org/wiki/Main_Page
[14]: https://github.com/okTurtles/dnschain
[15]: http://boingboing.net/2014/01/17/bitcloud-bitcoin-like-system.html
[16]: http://openlibernet.org/index.html
[17]: http://bitcore.io/
[18]: https://www.ethereum.org/
