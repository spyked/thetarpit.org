---
postid: '02c'
title: The mathematics and philosophy of hyperoperations
excerpt: Another dive into the world of mathematical foundations
date: October 5, 2014
author: Lucian Mogoșanu
tags: math
---

In "[On numbers, structure and induction][1]" I give an account on how the
concept of numbers is inextricably tied to mathematics. This might seem obvious
to the untrained eye, and I agree holds true for arithmetics; however, as far
as mathematics are concerned, taking "things that matter™", such as numbers,
for granted, is undeniably childish, for the simple reason that mathematics and
taking things for granted don't go well together. Thus, we explore not only how
numbers are purely mathematical objects, but also how they can be expressed in
more than one formalism, as there are usually many ways in which one can view
"things that matter™", such as numbers.

Also in my previous article, I deliberately avoid discussing anything other
than "succession", i.e. the natural unary operation from which the infinite set
of numbers arises, and addition. I do this only for the sake of simplicity,
when in fact the avoided is unavoidable: the "predecessor" is only a partial
morphism, and this partiality is reflected in more than mere addition, which is
why we have integers, fractionals, reals, imaginaries, and, moreover,
transcedentals, primes, perfects, and so on and so forth. The theory of numbers
is anything but simple to teach and learn.

It would therefore seem that, both for theoretical and practical purposes, we
require higher-order operations: we want to be able add numbers multiple times,
and so we get multiplication, and we often also want to be able to multiply
numbers multiple times, and so we get exponentiation. This is not a child's
plaything: addition, multiplication and exponentiation, together with the
relations arising between them, rule Life, The Universe and Everything in more
ways than the brain of the average human can comprehend. But I am preaching to
the choir, I do not need to convince the educated reader of the truth.

Let us now shift our focus on the following problem: mathematics, or at least
certain branches of mathematics deal with generalizations, that is, the
unification of sometimes seemingly unrelated concepts into a single theory.
This is especially desired by formally-inclined mathematicians, also (but not
only) because formalizing a single mathematical object is orders of magnitude
easier than formalizing a million of them; and this is where we get back to our
story about "numbers and stuff we are able to do with them".

It is natural to pose the following questions: given the conceptual sequence
of succession, addition, multiplication and exponentiation, what comes after?
We must be, and indeed we are, able to exponentiate numbers multiple times,
and so we get tetration. But then what comes after that? Well, we can tetrate
numbers multiple times, and so we get pentation. But then what comes after
that? And this is where I guess you got the general idea, an idea which
mathematicians way more competent than myself have already explored: what is
the generalization of these operations?

Said mathematicians[^1][^2][^3] apparently identify this abstraction through
what we know as [hyperoperations][2]. Quite isomorphically to natural numbers,
the set of these binary operations goes from "zeration" (what I previously
named "succession", in fact a unary operation), to addition, multiplication,
exponentation, and then to tetration, pentation, sextation and so on, ad
infinitum. I propose that we explore them ourselves from a computational
perspective, by defining them mathematically and in Haskell, then attempting to
(intuitively) find some basic general properties, and then, finally, by ranting
on this subject, hoping that his would help us to make sense of the whole that
are hyperoperations.

## Generalizing exponentiation

Going back to our [previous account][1], we defined natural numbers
recursively, or using the principle of induction, i.e. by stating that zero is
a natural number, and the "successor" of any given natural number is also a
natural number. This enumeration generates the set of natural numbers, which I
will refer to as $\mathbb{N}$ in the remainder of this post.

In Haskell, $\mathbb{N}$ is represented by the following algebraic data type:

~~~~ {.haskell}
data Nat = Zero | Succ Nat
~~~~

over which we define the function `(.+)` (addition) as an infix operator:

~~~~ {.haskell}
(.+) :: Nat -> Nat -> Nat
n .+ Zero       = n
n .+ (Succ n')  = Succ $ n .+ n'
~~~~

We know that multiplication involves repeated additions of the same number,
i.e. $3 \times 4 \equiv 3 + 3 + 3 + 3$. We therefore define `(.*)` recursively
in terms of `(.+)`:

~~~~ {.haskell}
(.*) :: Nat -> Nat -> Nat
_ .* Zero       = Zero
n .* (Succ n')  = (n .+) $ n .* n'
~~~~

We can use the same recipe to define exponentiation:

~~~~ {.haskell}
(.^) :: Nat -> Nat -> Nat
_ .^ Zero       = Succ Zero
n .^ (Succ n')  = (n .*) $ n .^ n'
~~~~

Note how the recursion steps for the three operations look very similar: they
all use partial application of the immediate lower-order operator, with the
exception of `(.+)`, where `Succ` is unary. Also note that all three
definitions are right-associative, that is, the recursion is done on the second
number, the number to the right. Intuitively, this must go the same for all
hyperoperations.

The base case, i.e. when the second number is zero, however differs for each of
the three definitions. Addition naturally defines the base case as the number
to the left, while multiplication and exponentiation yield constant numbers,
namely zero and one respectively. This fails to give us a clear intuition for
how to define higher-order operations: multiplication is repeated addition, so
a number added to itself zero times amounts to zero; exponentiation is repeated
multiplication, so a number multiplied by itself zero times amounts to one[^4];
what does a number exponentiated by itself zero times amount to then? As per
Goodstein[^2], we assume that $a\;\text{op}\;0 = 1$, where $\text{op}$ is a
hyperoperation of higher order than multiplication, or $\text{op} \equiv
\text{op}_n$, where $n \ge 3$.

The observation that $\text{op} \equiv \text{op}_n$ isn't at all arbitrary. In
fact, it's telling us that we can assign a number to each hyperoperation,
making the order of a given hyperoperation the property of countability; in
other words, the enumeration leads us to a family of (countable)
hyperoperations! However, for the sake of consistency with our Haskell
implementation, we choose to use functions to define the semantics of
hyperoperations.

We will therefore implement a Haskell function called `hyper n a b`, which has
the following properties:

* Zeration (`hyper` where $n = 0$) is defined as the right-associative `Succ`
  constructor (i.e. applied on the second parameter of the operation).
* Addition (`hyper` where $n = 1$) of a number $a$ to $0$ yields $a$.
* Multiplication (`hyper` where $n = 2$) of a number $a$ to $0$ yields $0$.
* `hyper`s where $n \ge 3$ of a number $a$ to $0$ yield $1$.
* `hyper`s where $n \ge 1$ of a number $a$ to a number $b$, $b \ge 1$, are
  computed recursively, i.e. they are formally defined as a recurrence, solved
  through induction[^1].

The properties are equivalent to the following Haskell implementation:

~~~~ {.haskell}
hyper :: Nat -> Nat -> Nat -> Nat
hyper Zero _ b                  = Succ b
hyper (Succ Zero) a Zero        = a
hyper (Succ (Succ Zero)) _ Zero = Zero
hyper (Succ _) _ Zero           = Succ Zero
hyper (Succ n) a (Succ b)       = hyper n a $ hyper (Succ n) a b
~~~~

Assuming that we have a `fromNum` function that converts Haskell numbers to
`Nat`s, we can now check our implementation:

~~~~
> hyper (fromNum 1) (fromNum 7) (fromNum 0)
7
> hyper (fromNum 1) (fromNum 7) (fromNum 17)
24
> hyper (fromNum 3) (fromNum 3) (fromNum 2)
9
> hyper (fromNum 4) (fromNum 3) (fromNum 2)
27
~~~~

The full source code is available in [Hyper.hs][3], feel free to mess around
with it.

## Basic properties of hyperoperations

To illustrate and prove the properties of hyperoperators, we will make use of
equational reasoning, assuming only the Haskell implementation provided in the
previous section. First we will show that the first hyperoperation (addition)
is associative. In the process, we will also show its commutativity[^5][^6].

**Theorem** (**T1**). Succession is associative. This is quite trivial,
following from the fact that `Succ` is in fact unary, yielding unique natural
numbers. If we apply induction, first `Succ Zero` is unique, then if we assume
that `n'` is unique, then `n = Succ n'` is unique. $\square$

**Lemma** (**L1**). $\forall n \in \mathbb{N}$, `Zero .+ n = n`. We show this
by induction on `n`. For `n = Zero`, we get:

~~~~ {.haskell}
Zero .+ Zero = Zero
~~~~

which simplifies using the base case of `(.+)`. For `n = Succ n'`, we
assume that `Zero .+ n' = n'` and iterate on the recursion step,
obtaining:

~~~~ {.haskell}
   Zero .+ Succ n' = Succ n'
=> Succ (Zero .+ n') = Succ n'
=> Zero .+ n' = n'
~~~~

which coincides with the induction assumption. $\square$.

**Lemma** (**L2**). $\forall a, b \in \mathbb{N}$,
`(Succ a) .+ b = Succ (a .+ b)`. Similarly, we perform induction on `b`.

For `b = Zero`:

~~~~ {.haskell}
   Succ a .+ Zero = Succ (a .+ Zero) -- (.+) base case
=>         Succ a = Succ a

~~~~

For `b = Succ b'`, the induction hypothesis is `Succ a .+ b' = Succ (a .+ b')`:

~~~~ {.haskell}
   Succ a .+ Succ b' = Succ (a .+ Succ b') -- (.+) recusion
=> Succ (Succ a .+ b') = Succ (Succ (a .+ b'))
=>        Succ a .+ b' = Succ (a .+ b') -- ind.
~~~~

$\square$

**Theorem** (**T2**). Addition is commutative, $\forall a, b \in \mathbb{N}$, 

~~~~ {.haskell}
a .+ b = b .+ a
~~~~

We perform induction using `b`. For `b = Zero`, we get

~~~~ {.haskell}
   a .+ Zero = Zero .+ a -- (.+) base case
=>         a = Zero .+ a -- L1
=>         a = a
~~~~

For `b = Succ b'`, we assume that `a + b' = b' + a` and we prove that:

~~~~ {.haskell}
   a .+ Succ b' = Succ b' .+ a -- (.+) recursion
=> Succ (a .+ b') = Succ b' .+ a -- L2
=> Succ (a .+ b') = Succ (b' .+ a)
=>        a .+ b' = b' .+ a -- ind
~~~~

$\square$

**Theorem** (**T2**). Addition is associative, $\forall a, b, c \in
\mathbb{N}$, 

~~~~ {.haskell}
a .+ (b .+ c) = (a .+ b) .+ c
~~~~

We'll take the same proof strategy as before. We choose `b` for induction to
attempt reducing the parenthesis to a reflexive proposition, or to the
induction hypothesis. First, for `b = 0` we get:

~~~~ {.haskell}
   a .+ (Zero .+ c) = (a .+ Zero) .+ c -- L1, (.+) base case
=>          a .+ c = a .+ c
~~~~

Then, for `b = Succ b'`, with `a .+ (b' + c) = (a .+ b') .+ c`:

~~~~ {.haskell}
   a .+ (Succ b' .+ c) = (a .+ Succ b') .+ c -- L2, (.+) recursion
=> a .+ Succ (b' .+ c) = Succ (a .+ b') .+ c -- (.+) recursion, L2
=> Succ (a .+ (b' .+ c)) = Succ ((a .+ b') .+ c)
=>        a .+ (b' .+ c) = (a .+ b') .+ c -- ind.
~~~~

$\square$

I'll let the reader explore other properties of hyperoperations through the
following exercises:

**Exercise** (**E1**). Prove commutativity and associativity for
multiplication. You might have to use other lemmas in addition to the ones
presented here. *Hint*: First prove the following particular case of
distribution of multiplication over addition: `a + a * b = a * (1 + b)`.

**Exercise** (**E2**). Try to use the same steps to prove associativity for
higher-order hyperoperations, with exponentiation as a prime trial. Find some
counter-examples. Indeed, it would seem that `hyper n`s for $n \ge 3$ aren't
associative! This once again goes beyond intuition, illustrating that `hyper`
is a weird function, or rather that it behaves differently than we'd expect it
to.

**Exercise** (**E3**). Prove that $\forall n, \in \mathbb{N}$,
`hyper n 2 2 = 4`.

## Conclusion and basement philosophy

This post explored the mathematics of hyperoperations from a computational,
i.e. layman's, perspective, providing a toy implementation in Haskell, such
that it is roughly equivalent to the formal description. We also showed a few
basic properties of the more commonly-used operations and gave a perspective to
explore further properties of the less common ones, or of hyperoperations in
general.

One question that lingers in the back of my mind is: how many of these
properties stem directly from the properties of numbers, and how many follow
from the properties of the definition of hyperoperations? I'm inclined to say
that numbers by themselves are useless, and it's the things that we do to them
that define their properties; for example we define primality in terms of
divisibility, divisibility in terms of division, division in terms of
subtraction and so on. 

What's more baffling is that numbers, whether seen in this unary form given by
the Peano axioms or in some other form[^7], are fundamental to our
logical-mathematical view of the world in ways that are hard to understand. We
made use of a bit of induction to prove stuff about numbers in this post -- and
it was in fact structural induction, even though it looks strikingly similar to
the mathematical one --, even though properties about numbers are used to
define induction!

Getting back to our hyperoperations, we have some other interesting things to
say about them too. Firstly, operations from pentation onwards "explode" very
quickly even for small numbers; that means they can be used to express numbers
that are sensibly larger than the number of atoms in the observable
universe[^8]. Secondly, the `hyper` function viewed as a relation on four
numbers (the three parameters and the result) is isomorphic to the set of
natural numbers. Finally, as far as `hyper` goes, infinity is way larger than
that, which goes to prove how little our feeble brains can actually encompass.

[^1]: Ackermann, Wilhelm. "Zum hilbertschen aufbau der reellen zahlen."
Mathematische Annalen 99.1 (1928): 118-133.

[^2]: Goodstein, Reuben Louis. "Transfinite ordinals in recursive number
theory." The Journal of Symbolic Logic 12.04 (1947): 123-129.

[^3]: Knuth, Donald Ervin. "Mathematics and computer science: coping with
finiteness." Science (New York, NY) 194.4271 (1976): 1235-1242.

[^4]: The algebraist's intuition here is that multiplication with zero yields
the identity element of the additive monoid, while exponentiation with zero
yields the identity element of the multiplicative monoid. Exponentiation on
natural numbers doesn't form a monoid, though, so this intuition doesn't help
with tetration (and, indeed, other hyperoperations) either.

[^5]: Note that commutativity does not hold for succession, given its rather
peculiar inclusion in the family of (binary) hyperoperations as a (unary)
operation.

[^6]: As a side note, I used Coq to check the correctness of said proofs. This
is a subject that I hope I will get to explore in the near future.

[^7]: Skew binaries are an interesting little weirdness of mathematics. Really,
have a look at them.

[^8]: And that's not even a big deal, we can use the entire range of IPv6
addresses to do this; hyperoperations can go way beyond that.

[1]: /posts/y00/01d-on-numbers-structure-and-induction.html
[2]: https://en.wikipedia.org/wiki/Hyper_operator
[3]: /uploads/2014/10/Hyper.hs
