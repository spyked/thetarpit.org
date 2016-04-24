---
postid: '027'
title: Bitcoin as infrastructure [iii]
date: August 9, 2014
author: Lucian Mogoșanu
tags: cogitatio
---

Also read: [Part I][1], [Part II][2].

## Part III: Bitcoin as infrastructure

Now that I have described "the bigger picture", I can finally focus on the
subject that I've set out to dissect. I promised that I wouldn't get into
details pertaining to finance and economics; however, I feel that I must
provide some background, especially that I myself wasn't very aware of Bitcoin
at the time when it appeared.

The idea of "electronic money" isn't by any means new; it had been an
interesting research subject in the field of distributed systems before 2009,
the year when the anonymous Satoshi Nakamoto published his Bitcoin white paper.
The main idea behind virtual currencies is that currency is in itself a token
whose value is (theoretically) determined by the value of various resources in
the market[^7]. In other words, money has no intrinsic value and it's used only
to quantify the value of useful stuff: for example I cultivate tomatoes and
sell a bunch of them for $x$ coins. Then I buy some other stuff I need, say,
computer games (since I don't produce computer games), for $y$ coins, and since
I only possess $x$ coins, I can only buy computer games for $y \leq x$. Thus
coins are a mediator, and a useful one indeed, since I don't know (and don't
care) whether computer game producers need or want to acquire tomatoes or not.

So virtual currency is, despite what some people might think, the ideal form of
currency, if we assume that energy spent on running computers has less value
than the costs of producing paper and/or metal tokens. The open problems before
2009 remained: who decides how many monetary units go into the market, and who
intermediates transactions?

The obvious answer to that would be the state and banks respectively. However,
we should note that banks are institutions traditionally used for depositing
and withdrawing money, plus credits and the such. Allowing them to intermediate
each single transaction would turn them into a single point of failure, and
it's stupid, to say the least, to assume that the system is infallible. The
same could be argued about the first problem: the state could in theory decide
how much money gets to be produced, e.g. instead of tying it to some scarce
resource, but we can't expect the state to make decisions that will [satisfy
everyone][3]. Thus Satoshi proposed an alternative design which is
decentralized, i.e. it eliminates the state and banks from the equation, and
which eliminates some technical problems, i.e. double-spending, by design.

The way it does that is still poorly understood by most people, therefore I
will attempt (and hopefully will not fail) to explain it[^8]: assuming that the
network contains money, a number $n > 0$ of accounts are open at a given time
and that the sums of money in all accounts are represented by a set
$A = \{a_1, a_2, \dots, a_n\}$, we could in theory create a transaction
$t_{ij}$ from $a_i$ to $a_j$, $a_i, a_j \in A$; thus $i$ transfers $x$ units to
$j$ and $a_i$ and $a_j$ get updated[^9].

Assuming that all the information above is accurate, the question is, how do we
prove that the transaction was made? i.e. that $a_i$ loses $x$ units and $a_j$
gains the same amount. The natural solution proposed by Satoshi involves
keeping a public database $T$ of transactions, which records all the
transactions from the beginning of the world to the current moment. Thus, if
$i$ updates his copy of the database and $j$ does the same thing, and $k$ and
so on do the same, then eventually the majority of the network will agree on
the transaction; as a consequence, all transactions are public. This is not
entirely dissimilar to the way DNS works, the main difference being that DNS is
structured hierarchically, while Bitcoin is implicitly peer-to-peer.

Having said all the above, the Bitcoin database, known as the
"blockchain"[^10], didn't start as I described it earlier. There was no money
in the system, which Bitcoin solves by introducing a "proof-of-work" framework:
to create money, one must "mine" it by solving a cryptography problem, e.g.
finding the transaction block which encodes to a particular hash. The problem's
difficulty increases as the database grows, and thus virtual coins, i.e.
bitcoins, become more and more scarce as the monetary mass grows. Miners are
however central to Bitcoin by providing transaction validation (the "agreement"
mentioned above) and are incentivized through transaction fees.

I won't discuss the model's validity and soundness[^11] here, but it's safe to
say that the community of Bitcoin enthusiasts are testing it and discussing its
problems since its beginnings, which doesn't automagically make the system
perfect, but it shows that it has worked in practice until now. I will leave
the technical debates to people more knowledgeable than myself.

It should be noted that while Bitcoin rests on top of the Internet's
infrastructure, it doesn't specifically require it: in theory, one could
validate transactions using pen and paper, although computers and the Internet
make it practical. It should also be noted that Bitcoin as I've described it is
more than a currency in the usual sense: it is in fact a protocol for
distributed transaction validation through voting.

In other words alternative blockchains can be created to use the same
infrastructure for various other applications, e.g. voting, file storage,
social networks and so on, and so forth. The possibilities are quite hard to
imagine, but we could begin with every piece of centralized software that would
naturally run in a decentralized fashion[^12] using a blockchain. Granted, this
would probably break the Web as we know it, but it would also break the [feudal
model][4] of the current Internet.

In the end this could prove to be an impractical dream, a dream which I'll
remain skeptical of just for the sake of pragmatism. But this aside, I can't
help but recognize the potential of this thing, since it's not so different
from how telephones looked in the '60s, personal computers in the '80s or the
Internet in the '90s. And to prove that I'm not the only crazy person thinking
about this, and more, that I'm not the first, nor the last, getting the idea of
Bitcoin-as-infrastructure, I will provide some examples of interesting
applications based on the infrastructure provided by Bitcoin before drawing a
conclusion to my essay.

**Next**: [Examples and conclusion][5]

[^7]: Rigorously speaking it is in fact established by the agents, based on the
value of other resources. E.g. if the demand for apples is high but the supply
is low, then the price-per-unit of apples in some arbitrary currency will
necessarily rise; on the other hand, if no one wants to use said currency for
exchanging apples, then the (non-intrinsic) "value" of said currency will
plummet. As far as economics go, this is mostly empirical evidence, although
the reasoning itself is sound.

[^8]: Not unlike many Haskell programmers attempt to explain monads and fail.
But it's the attempt that matters the most, as it crystallizes the idea in the
head of the storyteller.

[^9]: This is from an imperative rather than a formal mathematical point of
view, since identifiers never "get updated" in mathematics, rather they are
different at different (explicitly given) points in time $t$. The two views are
equivalent though, and one can be expressed using (subsets of) the other.

[^10]: Due to it being a chain of signed cryptographic hashes of transactions.

[^11]: Here's an interesting question: what would happen if a single entity
managed to achieve more than half of the network's mining power? And what if
that entity happened to be the state? I guess we're back to square one then.

[^12]: Facebook, most Google services and a plethora of other web applications
that kill their users' privacy for the sheer purpose of serving better ads.

[1]: /posts/y00/01f-bitcoin-as-infrastructure-i.html
[2]: /posts/y00/022-bitcoin-as-infrastructure-ii.html
[3]: /posts/y00/017-the-mechanics-of-socialism.html
[4]: https://www.schneier.com/blog/archives/2012/12/feudal_sec.html
[5]: /posts/y01/031-bitcoin-as-infrastructure-iv.html
