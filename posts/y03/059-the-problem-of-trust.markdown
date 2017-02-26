---
postid: 059
title: The problem of trust
date: February 26, 2017
author: Lucian Mogoșanu
tags: cogitatio
---

The concept of trust is as simple as it is deeply problematic. Let us
first [define it][mw]:

> **a** : assured reliance on the character, ability, strength, or truth
> of someone or something
>
> **b** : one in which confidence is placed

and the remaining definitions are more or less similar.

Human societies are built on trust, and thus the ability to place trust
in others, be they things or others of their kind, is a fundamental
quality of the Zōon Politikon. In fact nowadays we trust so many things
and so many people that this trait has become implicit in our way of
life. We must bear in mind however that trust is inherently
asymmetrical, so that the trusted needn't give his entruster one iota of
trust in return -- if we were able to quantitatively appreciate trust,
which as far as I know we do not.

When trust as a whole is broken or otherwise disappears by some other
means, society collapses and war ensues. That is not to say that lack of
trust (or distrust) is necessarily a cause of war; after all it is not
that Genghis Khan didn't trust the peoples he conquered, but that he
conquered them first and foremost because he could. Lack of trust is
also not a problem in and of itself -- (too much) trust is, especially
when it is not accompanied by [verification][reversing-lists].

Since I am an engineer by formation, I will use the closest example I
have available to formulate the problem of trust: let us imagine that we
are [the last remaining men on Earth][humanity] and that we wish to
build an advanced technological artifact, say, a high-performance
numerical computer. Now, how do we go about making that?

The approach of `n`-societies[^1] builds the state of the art in
computers by using large computer-factories relying on complex
[chains of dependencies][software-engineering-iii]. This works
principally because large numbers are readily available on both ends of
the chain; on one end lies the cheap overworked labour; on the other lie
[fat worms][slither] who are able to take in the end product in big
quantities. This approach works for now, but it has the major
disadvantage that it is fragile because of its multiple interdependent
points of failure; in other words, it is disadvantageous because of its
incompatibility with our previously enunciated scenario.

The approach of small societies, numbering as few as one individual,
[does not exist yet][future-hardware], a fact which is somewhat
disquieting.

Let us further imagine then that we had readily available
[synthesizers][3d-printing] to help us in our endeavour, along with
enough knowledge of hardware and software to allow us to build a system
from scratch. At this point we will have eliminated trust[^2] in other
hardware and software developers, who at the point of our
post-apocalyptic scenario are long gone anyway.

But this is not done yet, because now we have to trust the device
printing our chips either in terms of design-to-implementation
correctness or of lack of subtle malicious behaviour[^3]. Ideally we
would use the printer to make our own hardware printing device, but this
is necessarily incomplete, as demonstrated by Gödel. In other words we
cannot trust that the `n`th order printer-of-printers will not replicate
the same incorrect or malicious behaviours in their lower order
creations.

The naïvely correct approach would be to start by placing our trust in
the laws of physics, which we know to manifest in a specific way
according to common sense[^4] scientific experiments. From here we can
use fire to refine iron to make tools that help us make tools, and so on
until we are able to build the tools necessary to build computing
machines of a satisfactory performance. The viability of this approach
has been demonstrated by history; however, given the time required to
put it in practice, this might not the right approach from a pragmatic
point of view.

Assuming that the scarce society in our thought experiment still
contains leftover technology from our `n`-ancestors, an honest enough
avenue would be to employ common sense combined with existing tools as
means to verify existing systems. This is in itself a hard problem,
since there is no general method to this verification, and I doubt there
will ever exist one[^5].

Fundamentally this thought experiment reduces the problem of trust to
the question of trading off between outsourcing and independence. I have
no doubt that there are people who at least believe they have the answer
to this problem; however, history seems to show that in general there is
no stable point of equilibrium to balance the two situations.

One lesson we can take away from all this, though: knowledge is never
ever to be outsourced, for it is the primary prerequisite for the
ability to verify.

[^1]: This term is borrowed from the definition of "slave empires" in
    Trilema's [Republican Thesaurus][thesaurus].

[^2]: And moreover, [dependence][freedom-is-slavery].

[^3]: At the time of writing, this is a problem worthy of consideration,
    as illustrated in Yang et al., "A2: Analog Malicious Hardware",
    published at the 2016 IEEE Symposium on Security & Privacy.

[^4]: Common sense is used here merely as a device to put a halt to the
    "turtles all the way down" phenomenon described previously.

[^5]: I have actually thought about this. Stay tuned.

[mw]: http://www.merriam-webster.com/dictionary/trust
[reversing-lists]: /posts/y03/057-reversing-lists.html
[humanity]: /posts/y01/032-your-worth-to-humanity.html
[thesaurus]: http://trilema.com/2016/republican-thesaurus-with-vocabulary-and-dictionary/
[software-engineering-iii]: /posts/y03/04e-the-myth-of-software-engineering-iii.html
[slither]: /posts/y02/048-slither-io-unfairness.html
[future-hardware]: /posts/y03/04d-future-of-computing-hardware.html
[3d-printing]: /posts/y00/01c-3d-printing.html
[freedom-is-slavery]: /posts/y03/04f-freedom-is-slavery.html
