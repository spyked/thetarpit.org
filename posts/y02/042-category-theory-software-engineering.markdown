---
postid: 042
title: Category theory and its application in software engineering
date: January 30, 2016
author: Lucian Mogoșanu
tags: math, tech
---

I have touched on the subject of category theory in the past, motivated
partly by my enthusiasm of working with a mathematical framework that is
so simple yet so powerful, and partly by the usefulness of categorical
models in software.  This essay draws from previous posts
[on the old blog][bricks1] and from my previous experience with the
subject, and I am posting it hoping that it will represent a starting
point for other interesting writings.

I am fairly sure that most of the work in this post is in no way
original; that is, there are other publications where categorical
approaches to software modeling, and matters pertaining to category
theory in general, are already explained, and most probably better than
they are here. For example Steve Awodey has an excellent book providing
an in-depth mathematical exploration of category theory[^1]; Robert
Harper discusses on the (major) impact of categories on type theory[^2],
computation and computer programs; Brent Yorgey makes a really good
overview of the relation between categories and Haskell type
classes[^3]. There is much more material on the web and in books, and
while you're not required to peruse it in order to read this, I
certainly encourage you to have a look.

## Category theory: introduction, definitions

While mathematics is an exact "science"[^4], its methodology differs
from that of, say, physics or biology, which have fundamentally
different ojectives, although the latter very often make use of
mathematical means to make sense of the world. Instead, it'd be fairer
to find the origins of mathematics in philosophy, which discusses
concepts, or ideas, or essences, rather than objective experience.

For the last century or so all mathematicians and philosophers have been
in agreement on the fact that mathematics must have a philosophical and
logical basis. For quite a long time, that basis was, and to some degree
still is, set theory; the limitations of naïve set theory[^5] have been
thoroughly explored in the 20th century and the need for a "more
complete" theory of mathematics was and is still felt by
mathematicians. Even though nowadays we prefer using computers to solve
problems requiring mathematics, this has nothing to do with computers
themselves, although it has everything to do with the theory of
computation.

Category theory was for a while believed to be this new, previously
missing, foundation of mathematics. This doesn't seem to be the
consensus among mathematicians anymore, but despite that, categories
still play an important role in defining the new framework[^6]. Also
note that in Harper's Holy Trinity, the categorical approach defines the
so-called "universe of reasoning" in terms of mappings and structures, a
view that is very much in sync with that of software architecture and
software engineering.

What is then a category? According to the definition, any category
necessarily consists of the following three: *objects*, *morphisms* (or
*arrows*) and a *composition law* bearing well-defined properties.

Intuitively, any mathematical object could constitute an **object** in a
category.  Category theory classes often provide sets as the most
intuitive example of objects; that is, any set is an object in the
category of sets. Note that the categorical view doesn't necessarily
care about how an object is *defined*, but rather about its properties
in relation to the given category's arrows and the overall category's
structure. Formally, given a category $\mathcal{C}$, we can denote its
set of objects as $\text{Ob}(\mathcal{C})$.

Also intuitively, any mapping between two objects could constitute an
**arrow** in a category. The canonical example here is represented by
functions, i.e. mappings between sets, but many other binary relations
fit this description. An interesting example is that of
[partially-ordered sets][posets]. Formally, for a given category
$\mathcal{C}$ and two objects $A, B \in \text{Ob}({\mathcal{C}})$,
$\text{Hom}_{\mathcal{C}}(A, B)$ denotes the set of arrows from $A$ to
$B$; however, the function notation $\forall f, f : A \rightarrow B$ is
also often used.

Finally, **composition** is denoted using the "$\circ$" operator or
juxtaposition, and it represents a binary operation on two arrows in a
category. Intuitively, one may see composition similarly to function
composition: given a category $\mathcal{C}$, three arbitrary objects $A,
B, C \in \text{Ob}(\mathcal{C})$ two arrows $f \in
\text{Hom}_{\mathcal{C}}(A, B)$ and $g \in \text{Hom}_{\mathcal{C}}(B,
C)$, then there exists an arrow $h \in \text{Hom}_{\mathcal{C}}(A, C)$,
where $h \equiv g \circ f$. A good intuition is that the "path" from $A$
to $C$ could be represented as another arrow in $\mathcal{C}$.

Composition is *associative*; that is, given $f : A \rightarrow B$, $g :
B \rightarrow C$ and $h : C \rightarrow D$, then:

$(h \circ g) \circ f \equiv h \circ (g \circ f)$

Intuitively, this tells us that composition "paths" are unique and that
the order of application of composition doesn't matter.

Additionally, every object has an associated *identity* arrow; $\forall
A \in \text{Ob}(\mathcal{C})$, then:

$\exists 1_{A} \in \text{Hom}_{\mathcal{C}}(A, A)$

which is invariant under composition. That is, $\forall A, B \in
\text{Ob}(\mathcal{C})$, $\forall f : A \rightarrow B$,

$1_{B} \circ f = f \circ 1_{A} = f$.

These are all the elements defining a category. Intuitively, they
naturally apply to sets and functions, giving rise to the category of
sets, denoted **Set**: all sets are objects and all functions are
arrows; functions may be composed associatively and every set has an
identity function.

There are other examples of categories in the world of mathematics and
computer science, which I advise you to explore on your own. The
concepts of *functors* and *natural transformations* are also
fundamental to category theory, but I will skip them for now due to lack
of space. I will instead leave the remainder of this essay to a more
interesting example and attempt to model version control systems as
categories. This, to my knowledge, provides a new perspective on the
subject, so I'm hoping it will prove to be interesting and maybe even a
bit challenging.

## Example: The Git category

Those of you who are coming from software engineering should be familiar
with version control systems (VCS). VCS have been devised as
collaborative tools between programmers who want to share code and have
a means to keep track of changes in the code base of some particular
piece of software. They remain crucial to software development, although
nowadays technical people are using them to maintain all sorts of other,
usually text-based projects such as papers or web sites. The popularity
of [GitHub][github] has also drawn less technical people to this world
of programming, so everyone and their dog can keep a public project
nowadays.

One particular case of version control system are distributed version
control systems (DVCS). All VCS maintain a *repository* where code is
stored and where the entire history of a project is maintained as a set
of *commits*. In particular, DVCS state that every contributor to a
project has their own copy of the repository offline, and they can keep
their changes in sync with a remote repository by *pushing* their local
copy. We're not particularly interested in this aspect at the moment,
but it's interesting to note that our categorical model should also
apply to distributed systems.

Let's take the Linux kernel as an example: Linux is kept under version
control using [Git][git]. It has multiple branches and forks (remote
copies of a repository) and the code base of the kernel changes as new
commits are added to the remote repository. The code is therefore in a
particular **state** at a given point in time and its state changes with
each commit, usually by applying a patch, or a **diff**, which holds as
information the "difference", in lines of code (LOC) added or deleted,
between the old state and the new one. So far, so good.

Given that there are many possible modifications that could arise from a
given state, the code might diverge into multiple **branches** which
will later need to be **merged** or **rebased**. I won't go into detail
regarding these concepts, but they should nevertheless prove to be
interesting from a categorical point of view. For now we assume that the
repository goes through a list (as opposed to a graph) of states as it
changes, each change, or set of changes, being marked by a diff.

Intuitively, it should be fairly obvious that repository states can be
viewed as objects in a category: assuming for example that the commit
hashes in a Git repository are unique[^7], each hash marks the
identifier of a "version" of the code in that repository. If we wanted
to prove an isomorphism between code revisions and mathematical sets, we
would intuitively see each revision as a set comprising arbitrary
strings, i.e. the actual code.

Also intuitively enough, we could look at commit diffs in the same way
we look at a categorical arrow, each diff providing a mapping between
two states in the same way a function provides a mapping between two
sets. For example, in git, this difference is provided in terms of lines
added and removed from a certain code base[^8].

This representation gives rise to a small complication. In practice
there is usually more than one way to go from one revision to
another. Given for example a certain code base upon which various
modifications have been made, the developer may choose to either create
a big commit containing all the changes, or various smaller commits,
each comprising a unit of their work[^9]. For the sake of making our
model simpler, we can define a "minimal commit" unit, represented by the
removal or addition of a certain line in a code base.

We also note that commit diffs are composable most of the
time[^10]. Given two successive commits, one may represent them as a
single commit, e.g. by [squashing][git-squash] them in Git, or by simply
applying git-diff between two commit hashes. This is fortunate for us,
as it allows us to represent a possible commit as a chain of
compositions of multiple "minimal commits". The possible compositions
are conceptually very similar to a [Hasse diagram][hasse-diagram],
which, interestingly enough, provides an analogy between commits and
posets.

Finally, we can look at the empty diff, i.e. the diff with no additions
and no removals, as the canonical representation of an identity
arrow. Git doesn't actually allow empty commits, given that the new
generated repository state would be (needlessly) identical to the old
one, but we can model them anyway, as we know for sure that a git-diff
between an arbitrary commit hash and itself will always be empty.

From all the above emerges the Git category. The usefulness of this
representation is a whole different problem, but I am guessing that
various operations, e.g. merging, rebasing, defining submodules or other
useful operations that haven't been yet designed into state of the art
DVCS, can be represented as monadic actions. This of course would
involve answering deeper questions, such as what is an endofunctor in
the Git category, but for the sake of brevity we will stop this train of
thought here.

## Exercise: The Blockchain category, analogy with DVCS

The [blockchain][blockchain] is a database design coming from
Bitcoin[^11]. Although the idea was conceived specially for implementing
a new form of [representing money][infrastructure-iii], its uses may
theoretically go [beyond that][infrastructure-iv], into other
distributed systems and applications.

Simply put, the blockchain is a distributed chain of transactions. It is
distributed in the sense that all the participants, e.g. in the Bitcoin
system, should hold a copy of it. It contains transactions, that is,
statements that a certain piece of information, e.g. money in Bitcoin's
case, is transferred from one participant to the other, in the broad
sense that a "participant" is the same thing as an
account. Transactions, and more specifically parent transactions, are
identified by their hashes.

There is an immediate analogy between VCS and blockchains. The
categorical likeness of the two follows from that directly: in both
cases, system states are objects and transitions between states are
arrows; in both cases, arrow composition is representable and both allow
the existence of a conceptual identity transaction. This shows that the
architectural differences between the two are very few.

The design and implementation differences are in the
details. Transactions are inserted in the blockchain by a consensus
protocol; in Git, the policy for insertion is determined by the
computing systems where the bare repositories are stored. Git
transactions are independent of their content, containing anything from
source code to binary data; blockchain transactions have a more
restrictive format, depending on their application.

In theory one could generalize databases[^12] using categories. These
examples show that category theory is or could be, among other
mathematical abstractions, very useful to defining software both
architecturally and at the implementation level. Given that software
developers are faced with the pain of building robust and/or resilient
systems in a context where software verification and specification
doesn't scale, such abstractions are (arguably) needed now more than
ever.

[^1]: Awodey, Steve. Category theory. Vol. 49. Oxford University Press,
    2006.

[^2]: [The Holy Trinity][trinitarianism]

[^3]: [Typeclassopedia][typeclassopedia]

[^4]: In the broadest sense of the word "science", that coming from its
Latin root, where its meaning overlaps with that of "knowledge".

[^5]: [Russell's paradox][russell], for example.

[^6]: Univalent Foundations Program. [Homotopy Type Theory: Univalent
Foundations of Mathematics][hott]. Univalent Foundations, 2013.

[^7]: Which, by the way, they aren't. Fortunately the basic properties
of the SHA-1 hash make collisions [highly improbable][sha-1-git], and in
theory one could devise a (D)VCS commit addressing scheme that
completely avoids this problem.

[^8]: I am deliberately avoiding to see repositories as collections of
files, as this would make our definition a lot more complicated.

[^9]: This is not an easy problem, as seen in [Commit Often, Perfect Later,
Publish Once][git-best-practices].

[^10]: There is an interesting mention to be made here regarding merge
conflicts. In mathematical terms, this only tells us that the "minimal
diff" doesn't provide a full mesh of mappings between repository states.

[^11]: Nakamoto, Satoshi. "[Bitcoin: A peer-to-peer electronic cash
system.][bitcoin]" Consulted 1.2012 (2008): 28.

[^12]: Transactions are of particular interest to us in this post, but other
aspects such as relational algebra could be seen as a particular case of
categories. See "[Category Theory as a Unifying Database Formalism][database]"
for more details.

[bricks1]: http://lucian.mogosanu.ro/bricks/o-introducere-usor-neobisnuita-in-domeniul-arhitecturii-software/
[trinitarianism]: http://existentialtype.wordpress.com/2011/03/27/the-holy-trinity/
[typeclassopedia]: https://www.haskell.org/haskellwiki/Typeclassopedia
[russell]: http://en.wikipedia.org/wiki/Russell%27s_paradox
[hott]: http://homotopytypetheory.org/book/
[posets]: http://en.wikipedia.org/wiki/Partially_ordered_set
[github]: https://github.com/
[git]: http://git-scm.com/
[sha-1-git]: http://git-scm.com/book/es/v2/Git-Tools-Revision-Selection
[git-best-practices]: https://sethrobertson.github.io/GitBestPractices/
[git-squash]: http://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#Squashing-Commits
[hasse-diagram]: http://mathworld.wolfram.com/HasseDiagram.html
[blockchain]: https://en.bitcoin.it/wiki/Block_chain
[bitcoin]: https://bitcoin.org/bitcoin.pdf
[infrastructure-iii]: /posts/y01/027-bitcoin-as-infrastructure-iii.html
[infrastructure-iv]: /posts/y01/031-bitcoin-as-infrastructure-iv.html
[database]: http://math.mit.edu/~dspivak/informatics/notes/unorganized/PODS.pdf
