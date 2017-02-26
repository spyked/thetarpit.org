---
postid: 057
title: Reversing lists, and on how formal methods are not an unambiguously useful tool for software verification
date: January 29, 2017
author: Lucian Mogoșanu
tags: cogitatio, math, tech
---

In his [blog post][heiser-verified] "Verified software can (and will) be
cheaper than buggy stuff" Gernot Heiser argues that in the future it
will be cheaper to formally verify software, including, not limited to,
but *especially* the high-assurance stuff, than to deploy buggy,
unverified versions of it; and since we're talking about high-assurance
software, this would be taking into account the risks of critical bugs
occuring and the costs involved[^1]. To quote:

> Our paper describing the complete seL4 verification story analysed the
> cost of designing, implementing and proving the implementation
> correctness of seL4. We found that the total cost (not counting
> one-off investments into tools and proof libraries) came to less than
> $400 per line of code (LOC).
>
> [...]
>
> Another data point is a number quoted by Green Hills some ten years
> ago: They estimated the full (design, implementation, validation,
> evaluation and certification) cost of their high-assurance microkernel
> to be in the order of $1k/LOC.
>
> In other words, we are already much cheaper than traditional
> high-assurance software, and a factor of 2-3 away from low-assurance
> software. If we could close the latter gap, then there would be no
> more excuse for not verifying software.

I have a lot of respect for Heiser and his crazy idea of driving
microkernels[^2] towards full correctness. I will however leave aside
the appeal to authority that he's a great researcher and I'm mostly
nobody, and note that I am completely at odds with the dollars per LOC
metric for measuring costs. This seems like a computed average value,
which I am not convinced has too much relevance in general, falling in
the same category as the man-hour metric.

We do know that seL4 has about 9000 LOC, which brings us to about 3
milion and a half dollars total costs, not counting tools and proof
libraries. This may not be much of a cost for DARPA, but it does mean a
lot of resources for the average guy who wants to make a business in
this world. Also, to twist the knife a bit, tools and proof libraries
add to what I call "the problem of trust"[^3].

In this context, the problem of trust instantiates to the fact that some
-- maybe most -- software is written in a high-level programming
language, which brings the need of translation of high-level code to
machine code using a compiler. To achieve full system verification we
need to verify the compiler itself, which has been done by partially
modelling said high-level language in the higher-level language of a
proof assistant. The proof assistant ensures that the proof is
mechanically sound, but the proof assistant itself is not safe from
bugs, which reduces our problem to at least one of Gödel's
incompleteness theorems.

This brings into discussion the following question: given a fair amount
of mathematical skill, can a fairly skilled engineer verify the
correctness of a fairly-sized system while placing a minimal amount of
trust in *assistance* tools? Or, in other words, assuming that the tools
are only there to *assist*, not to replace, can the engineer be provided
with extra value while actually reading the code and working to
understand the system[^4]?

I tend to think that Heiser's Cogent approach, a follow-up of the seL4
work, is useless. Looking at the Cogent git repository, it seems like a
huge tool requiring a considerable amount of computational resources,
while providing no extra help in making the system more palatable to our
fairly skilled engineer. In fact it makes it *less* palatable by
requiring the engineer to also understand Cogent, or give our engineer
the option of viewing Cogent as a black-box, which beats the purpose of
its open source-ness.

But instead of stating empty accusations, let us try to verify a small
piece of software which is a potential part of any system, so it could
be included in a so-called proof library[^5]. This marks the beginning
of a very long text, so grab some coffee, a pen and a piece of paper and
brace yourself. We will specify a common data type in most languages,
lists, and formally verify a small part of their properties. Formal
verification of a piece of software requires firstly a representation of
that software, and secondly a model of execution for it.

Note that while we will use a formal language for this purpose, we will
not employ any proof assistant to aid us, but instead we will rely
completely on the power of our intellect.

## The list abstract data type, and two operations over lists

In computer science, lists are typically defined as:

~~~~
List ::= [] | Value : List
~~~~

The formal language used to define lists is very similar to the
Backus-Naur Form: `::=` means "is", so `List` is a data type and `[]`
and `Value : List` are potential values of that data type. `[]` and `:`
are the two constructors of values of the type `List`: `[]` denotes the
empty list, while `x : L` denotes a value `x` prepended to a list `L`
using the `:` operator. So the list `[1, 2, 3, 4]` can be represented in
our language as

~~~~
1 : (2 : (3 : (4 : [])))
~~~~

with the parentheses used to make associativity explicit. For the sake
of readability we will consider that `:` is right-associative, so the
previously-defined list can also be written as

~~~~
1 : 2 : 3 : 4 : []
~~~~

To keep things short, let's assume our language allows us to define
functions such as `f(x) = x`, and functions of multiple parameters such
as `g(x,y) = x : y : []`. Also, let us assume that `Value`s can be
anything; I used the symbols `1`, `2`, `3` and `4` previously, but they
can be anything we want.

Again, for the sake of brevity, we will assume that the computational
execution model of our language is simple substitution, under an
arbitrary order. So, reusing our previous examples, `f(2)` and `2` are
equivalent under substitution, and so are `g(1,jabberwocky)` and `1 :
jabberwocky : []`.

Equipped with this knowledge we may now define two operations on lists:
concatenation (or "append"), which we will denote `app`, and reversal,
which we will denote `rev`. Note that these are both the *definitions*
and *specifications* of the operations. We may informally state that
"reversing a given list yields the list which has the same elements but
in the exact opposite order (e.g. right-to-left, as opposed to
left-to-right)", but we have no way of accurately *specifying* this in
our language other than by defining `rev` and postulating that "`rev`
reverses any given list". The same goes for appending lists.

I will mark the definitions' names in parentheses, as follows:

~~~~
app([]    , L2) = L2              (a1)
app(x : L1, L2) = x : app(L1, L2) (a2)
~~~~

There are two interesting things to note here. One is that we use
substitution to *pattern match* `app`'s arguments; by definition there
are only two potential types of values that any list can take, `[]` and
`x : L1`. The second observation is that under substitution, any
application of `app` on two finite lists[^6] is guaranteed to
terminate. This second property can be proven, but the demonstration
falls out of the scope of this essay.

We will use `app` to define `rev` the following way: reversing an empty
list yields an empty list; reversing a non-empty list is equivalent to
`app`ing the head of the list to the reversal of the rest of the list:

~~~~
rev([])    = []                  (r1)
rev(x : L) = app(rev(L), x : []) (r2)
~~~~

So, this is it, the implementation of the two functions. It's pretty
simple and it can be implemented almost ad-literam in most of the
commonly known programming languages. In so-called "functional
languages" we get these implementations almost for free.

## List reversal is involutive, the shortest proof I could muster

Reversal has an interesting property, namely that any list reversed
twice yields the initial list. This is called *involution*, and we will
define it for `rev` as a theorem:

**Theorem** (**T1**). `rev` is involutive, i.e., for any list `L`,

~~~~
rev(rev(L)) == L
~~~~

where `==` denotes structural *and* value-wise equivalence[^7].

Let's try to demonstrate this. We will do this by deconstructing `L`
into all possible values. Since `:` is defined recursively, we will use
structural induction -- which is very similar to the mathematical
induction taught in high-school -- to prove that the property holds. So
we have two cases:

**T1. a.** For `L = []`, this can be proven by applying substitution
under `r1` twice:

~~~~
rev(rev([])) == []
    ---r1--
rev([])      == []
---r1--
[]           == []
~~~~

**T1. b.** For `L = x : L'`, where `L'` is an arbitrary list, we assume
by induction that `rev(rev(L')) = L'`. Hopefully we will get to a form
where we can apply this substitution and obtain trivial equivalence:

~~~~
rev(rev(x : L'))          == x : L'
   -----r2-----
rev(app(rev(L'), x : [])) == x : L'
~~~~

At this point we're pretty much stuck. One option would be to
deconstruct `L'` and hope we get somewhere, but I'm willing to bet that
would get us nowhere. We're not left with much besides that. The astute
computer scientist will observe that we're applying `rev` on an `app`,
which is supposed to tell something. The even more astute computer
scientist will observe that there must be a relation between `rev` and
`app`[^8].

More precisely, reversing an append between two lists should also yield
an append form, but between the two lists reversed, with the arguments
to the append reversed. Let's stop for a moment and write this as a
lemma.

**Lemma** (**L1**). Given two lists `L1` and `L2`, the following is
always true:

~~~~
rev(app(L1, L2)) == app(rev(L2), rev(L1))
~~~~

which is quite intuitive, if we think of it. Let's try to prove
this. Since `app`'s recursion is done on the first argument, our best
bet is to try and deconstruct `L1`.

**L1. a.** `L1 = []`. This is pretty easy, as we can intuitively
substitute under definitions `a1` and `r1`:

~~~~
rev(app([], L2)) == app(rev(L2), rev([]))
    -----a1----                  ---r1--
rev(L2)          == app(rev(L2), [])
~~~~

and we're stuck again; but we notice that the right hand of our equation
is pretty trivial by nature. We already know by definition that
concatenating an empty list and a list yields the latter, but we also
need to prove that concatenating a list and an empty list yields the
former. That is:

**Lemma** (**L2**). Appending an empty list to a list `L1` will yield
`L1`, i.e.:

~~~~
app(L1, []) == L1
~~~~

The proof should be straightforward, by deconstructing `L1`.

**L2. a.** `L1 = []`

~~~~
app([], []) == []
----a1-----
[]          == []
~~~~

**L2. b.** `L1 = x : L1'`, where we assume by induction that `app(L1',
[]) == L1'`.

~~~~
app(x : L1', []) == x : L1'
-------a2-------
x : app(L1', []) == x : L1'
    --ind_L2b---
x : L1'          == x : L1'
~~~~

So, we've finally proven *something*! Let's get back to **L1. a.**. We
know that our `L1 = []` and we're left with proving that:

~~~~
rev(L2) == app(rev(L2), [])
           -------L2-------
rev(L2) == rev(L2)
~~~~

We're now left with one case for *Lemma 1*.

**L1. b.** `L1 = x : L1'`, where we assume by induction that given a
list L2, we have following relation:

~~~~
rev(app(L1', L2)) == app(rev(L2), rev(L1'))  (ind_L1b)
~~~~

We try to go the straightforward way:

~~~~
rev(app(x : L1', L2)) == app(rev(L2), rev(x : L1'))
    ------a2--------                  -----r2-----
rev(x : app(L1', L2)) == app(rev(L2), app(rev(L1'), x : []))
---------r2----------
app(rev(app(L1', L2)), x : []) == app(rev(L2), app(rev(L1'), x : []))
    -----ind_L1b-----
app(app(rev(L2), rev(L1')), x : []) ==
app(rev(L2), app(rev(L1'), x : []))
~~~~

We're stuck again, but we trivially observe that what we need to prove
is that `app` is associative.

**Lemma** (**L3**). `app` is associative, i.e., given three lists
`L1`, `L2` and `L3`, we have:

~~~~
app(app(L1, L2), L3) == app(L1, app(L2, L3))
~~~~

which we will try to prove by deconstucting `L1`.

**L3. a.** `L1 = []`, gives us

~~~~
app(app([], L2), L3) == app([], app(L2, L3))
    -----a1----         --------a1----------
app(L2, L3)          == app(L2, L3)
~~~~

**L3. b.** `L1 = x : L1'`, assuming that

~~~~
app(app(L1', L2), L3) == app(L1', app(L2, L3))  (ind_L3b)
~~~~

we reason that:

~~~~
app(app(x : L1', L2), L3) == app(x : L1', app(L2, L3))
    -------a2-------         ------------a2-----------
app(x : app(L1', L2), L3) == x : app(L1', app(L2, L3))
----------a2-------------        --------ind_L3b------
x : app(app(L1', L2), L3) == x : app(app(L1', L2), L3)
~~~~

Now we can return to **L1. b.** (again!). We had to prove that:

~~~~
app(app(rev(L2), rev(L1')), x : []) ==
app(rev(L2), app(rev(L1'), x : []))
~~~~

which can be trivially proven using **Lemma 3**.

Long story short, we need two ancillary lemmas to prove one lemma that
hopefully will help us prove **Theorem 1**. But before that, let's prove
another simple lemma, which, as we will see, will also be of help.

**Lemma** (**L4**). Reversing a singleton list is reflexive, i.e.

~~~~
rev(x : []) == x : []
~~~~

We apply `r2` and we obtain:

~~~~
app(rev([]), x : []) == x : []
    ---r1--
app([], x : [])      == x : []
------a1-------
x : []               == x : []
~~~~

Finally, **T1. b.** We assumed that `rev(rev(L')) = L'` and we have to
prove that:

~~~~
rev(app(rev(L'), x : []))      == x : L'
-------------L1----------
app(rev(x : []), rev(rev(L'))) == x : L'
    ----L4-----  ---ind_T1----
app(x : [], L')                == x : L'
------a2-------
x : app([], L')                == x : L'
    -----a1----
x : L'                         == x : L'
~~~~

Thus we have, after a bit of effort, proved a property of list reversal,
but in the process we managed to prove other things, such as the
associativity of concatenation and the reflexivity of reverse applied on
singleton lists. This however is far from the entire story.

## An alternate definition of `rev`, and a proof of equivalence

In addition to proving *properties* about programs, it is often required
of so-called "proof engineers"[^9] to prove that two programs are
*equivalent*. This is equivalent to showing that for all the inputs of a
program, the outputs are exactly the same, but in fact it isn't as
simple as it sounds, as both the input space, the output space and the
internal state of a program -- which must be somehow exposed in the
specification -- can be too large to simply enumerate.

Consider for example the problem of proving that for a given natural
number `n`, the sum of all the numbers up to `n` equals `(n * (n +
1))/2`, which is the same as proving that the former sum and the latter
formula compute the same thing. This is easy enough to prove
mathematically, but it's not trivial to show using an axiomatic formal
system. Some questions that will inevitably arise is,
[what is a number][numbers] and how can it be represented? What do `+`,
`*` and `/` mean? What are the properties of all these operations?  And
so on and so forth.

Proofs of equivalence may also be necessary in order to show that a
program implemented in two programming languages "does the same thing"
in both implementations, at least in some respects. This is the case
with seL4 being initially implemented in Haskell, then in C, which
required a proof that the C implementation "does the same things" as the
Haskell one. We will show that it is also useful for our simple `rev`
example.

Our `rev` implementation, which, as we said, is also our formal
specification for list reversal, suffers from one serious issue. Since
it appends values to the end of the list, its worst case computational
complexity is `O(n^2)`[^10]. However the same functionality can be
implemented as a function running in `O(n)`, which for functional
languages also provides other practical advantages such as optimization
of tail recursion.

The implementation is also simple: if we take the elements in a given
list `L` one by one and we put them in another list using `:`, then
eventually we will be left without elements in the first list, and the
second list will contain the initial elements in the reversed
order. Let's define a function called `rev'` that has an additional
parameter used exactly for this purpose:

~~~~
rev'([]   , A) = A               (r3)
rev'(x : L, A) = rev'(L, x : A)  (r4)
~~~~

Note that this is not immediately intuitive, as we must give `A` a
specific value when we call `rev'`. We can give a simple example of
evaluation by substitution:

~~~~
rev'(1 : 2 : 3 : [], A) =(r4) rev'(2 : 3 : [], 1 : A) =(r4)
rev'(3 : [], 2 : 1 : A) =(r4) rev'([], 3 : 2 : 1 : A) =(r3)
3 : 2 : 1 : A
~~~~

so in order to reverse a list `L` using `rev'`, all the calls to it must
have the form `rev'(L, [])`[^11].

We have shown through a simple example that `rev'` does the same thing
as `rev`, but given our neat formal language, we can actually put this
in the form of a theorem:

**Theorem** (**T2**). Given a list `L`,

~~~~
rev(L) == rev'(L, [])
~~~~

As before, the sane approach to proving this is to deconstruct `L`.

**T2. a.** `L = []`, thus

~~~~
rev([]) == rev'([], [])
---r1--    -----r3-----
[]      == []
~~~~

**T2. b.** `L = x : L'`, assuming the induction hypothesis `rev(L') ==
rev'(L', [])`. We get:

~~~~
rev(x : L')          == rev'(x : L', [])
----r2----              ------r4-------
app(rev(L'), x : []) == rev'(L', x : [])
~~~~

Expectedly, we are stuck. None of the properties we know (including the
induction hypothesis) seem to help, and deconstructing `L'` might bring
us to a uselessly infinite loop. Looking at this deeply -- and
unfortunately we cannot escape this leap in logic -- the astutest
computer scientist can figure out that, given two lists `L1` and `L2`,
there is some sort of link between `app(L1, L2)` and `rev'(L1, L2)`. The
former takes elements from `L1` and puts them into `L2` *from right to
left*, while the latter does the same, only *from left to
right*[^12]. So the place where we're stuck in **Theorem 2** reveals a
deeper property, which we will put in the form of a lemma.

**Lemma** (**L5**). Given two lists, `L1` and `L2`, the following holds:

~~~~
app(rev(L1), L2) == rev'(L1, L2)
~~~~

We use the same pattern of reasoning as before:

**L5. a.** `L1 = []`, thus

~~~~
app(rev([]), L2) == rev'([], L2)
    --r1---         -----r3-----
app([], L2)      == L2
----a1-----
L2               == L2
~~~~

**L5. b.** `L1 = x : L1'`, assuming that given an `L2` list,

~~~~
app(rev(L1'), L2) == rev'(L1', L2)  (ind_L5b)
~~~~

then

~~~~
app(rev(x : L1'), L2)          == rev'(x : L1', L2)
    -----r2-----                  --------r4-------
app(app(rev(L1'), x : []), L2) == rev'(L1', x : L2)
~~~~

We're stuck yet again, but the right hand side of the equation provides
us with a hint that is not immediately intuitive. We have `rev'(L1', x :
L2)`, which is similar to the one in the induction hypothesis, only the
second argument of `rev'` has a different value. I haven't gone into the
logical bowels of this problem until now, but notice that the induction
hypothesis holds *for all* `L2`, not necessarily the `L2` in the
equation. In other words, `L2` is universally quantified in the
induction hypothesis[^13]!

Thus we can instantiate `L2` in `ind_L5b` to `x : L2`, turning this
into:

~~~~
app(app(rev(L1'), x : []), L2) == app(rev(L1'), x : L2)
~~~~

This is a more general statement to prove, so let's put it in its own
lemma.

**Lemma** (**L6**). Given two lists `L1` and `L2`, concatenating
`app(L1, x : [])` and `L2` is the same as concatenating `L1` and `x :
L2`.

~~~~
app(app(L1, x : []), L2) == app(L1, x : L2)
~~~~

We deconstruct `L1`, as usual:

**L6. a.** `L1 = []`

~~~~
app(app([], x : []), L2) == app([], x : L2)
    ------a1-------         -------a1------
app(x : [], L2)          == x : L2
------a2-------
x : app([], L2)          == x : L2
    -----a1----
x : L2                   == x : L2
~~~~

**L6. b.** `L1 = y : L1'`, with the induction hypothesis that given a
list `L2`,

~~~~
app(app(L1', x : []), L2) == app(L1', x : L2)  (ind_L6b)
~~~~

Our reasoning goes:

~~~~
app(app(y : L1', x : []), L2) == app(y : L1', x : L2)
    ---------a2---------         ---------a2---------
app(y : app(L1', x : []), L2) == y : app(L1', x : L2)
-------------a2--------------
y : app(app(L1', x : []), L2) == y : app(L1', x : L2)
    --------ind_L6b----------
y : app(L1', x : L2)          == y : app(L1', x : L2)
~~~~

Note that **Lemma 6** is a very neat simplification rule that we can use
back in **Lemma 5**:

**L5. b.**

~~~~
forall L2. app(rev(L1'), L2) == rev'(L1', L2)       (ind_L5b)

app(app(rev(L1'), x : []), L2) == rev'(L1', x : L2)
------------L6----------------
app(rev(L1'), x : L2)          == rev'(L1', x : L2)
-ind_L5b(L2=x : L2)--
rev'(L1', x : L2)              == rev'(L1', x : L2)
~~~~~

Now that we've finally proven **Lemma 5**, we can move back to **Theorem
2**:

**T2. b.** Assuming the same induction hypothesis (that isn't useful
here anyway), we apply **Lemma 5**, yielding:

~~~~
app(rev(L'), x : []) == rev'(L', x : [])
--------L5----------
rev'(L', x : [])     == rev'(L', x : [])
~~~~

Thus we have the full proof that the two `rev` functions are
equivalent. As an observation, this isn't mind-numbingly difficult, but
it can take something up to two hours for a fairly skilled engineer to
grok this[^14]. Given a proof assistant with which the fairly skilled
engineer is not necessarily acquainted, it can take more than that.
Given that we can make decent leaps in logic which won't hurt the
overall reasoning, while something such as Isabelle/HOL has its own
peculiar constructs that require some training even for the experienced
programmer, I'd say that our mind-based ad-hoc concocted formalism wins
hands down.

## Concluding remarks

A good exercise for the aspiring software proof engineer is to imagine
(and exercise) how this approach scales up to a full system[^15]. For
real software the biggest part of this work goes into the brain-wreckage
that is correct specification within the formalism: some formalization
of the C language might not like the way one uses pointers, so entire
data structures have to be rethought in order for the proof to
continue. For other parts the engineers might just have to assume
correctness -- what if the hardware has bugs[^16]? what if the compiler
generates broken code? what if the language run-time has bugs?  Haskell
runs on glibc, which... well.

Another thing to consider is that real-world high-assurance systems
usually run on imperative languages such as well-specified subsets of
C. But for the sake of fun let's take (Common) Lisp, which has been my
favourite language for a while. I will give a Lisp implementation of
`rev'`, which I name `rev-acc`:

~~~~{.commonlisp}
> (defun rev-acc (L A)
    (if (null L)
        A
        (rev-acc (cdr L) (cons (car L) A))))
REV-ACC
> (rev-acc '(1 2 3) '())
(3 2 1)
~~~~

This implementation can be further optimized into an equivalent
imperative (and uglier) implementation, which I will name `rev-imp`. I
will use the `do` macro to do this:

~~~~{.commonlisp}
> (defun rev-imp (L A)
    (do ((x (pop L) (pop L)))
        ((null L) (push x A))
      (push x A))
    A)
> (rev-imp '(1 2 3 4) '())
(4 3 2 1)
~~~~

The Lisp family has the advantage that the core language is very well
specified[^17] and its execution model is surprisingly easy to
understand. Even so, imperative programs are not inherently simple to
formalize, since they incur the notions of time, execution steps and
program state, requiring specific operational semantics. Once these are
defined, one can formally verify that `rev-imp` and `rev-acc` (or
`rev-imp` and a Lisp implementation of `rev`) are equivalent, although
this is nowhere near trivial.

Coming from a formal methods dilettante and a computer scientist and
engineer[^18], the conclusion to this essay is somewhat self-evident:
formal methods are good as mental exercise and a nice tool for learning;
maybe a nice tool for intellectual wankery, at least in software. But
cheaper than [software that doesn't suck][software-engineering]? And for
all the others, bugs, a thing of the past? I very much doubt that.

[^1]: These are generally hard to estimate, but we can consider examples
    such as the Challenger disaster, Ariane 5, hardware bugs such as
    Intel's FDIV bug and so on. Analyzing the causes and the costs
    behind all these might make an interesting exercise, but maybe for
    another time.

[^2]: I discussed them very briefly in the past, mentioning that
    operating system design is in fact plagued by
    [a more general problem][linguistic-barrier-os] that is not entirely
    solved by microkernels and is generally ignored by the engineering
    and scientific community. In other words, it seems that UNIX has
    become "enough for everybody" and there are small chances of this
    changing in the current culture. Maybe in the next one, who knows.

[^3]: I promise to detail this in a future essay. In short, the
    problem's statement is that outsourcing trust in a component of the
    system does not magically remove the potential problems arising from
    said component, and that this issue goes "turtles all the way down"
    to the wheel and the fire, or to the fabric of the universe, if you
    will.

[^4]: I'm not even questioning whether reading the code and
    understanding the system is worth the engineer's time. A fair
    understanding of the system is an imperative prerequisite, any
    questioning of this being not only silly, but downright
    anti-intellectual.

[^5]: Yes, library code requires reading and understanding as well! No
    sane person ever went to the library to grab a piece of text and use
    it without reading it beforehand.

[^6]: We have no concept of "non-finite lists" in our language anyway.

[^7]: Without getting into gory details, structural equivalence means
    that for our abstract data type, two values of the form `a : b : c :
    []` and `d : f : e : []` are the same, whereas `a : b : []` and `d :
    f : e : []` are different. Value-wise equivalence denotes that two
    arbitrary values of the type `Value` are the same, i.e. `jabberwocky
    == jabberwocky`.

[^8]: Very much related to the fact that `app` is a free monoid under
    strings (or lists, if you will) and that `rev` is a sort of negation
    operation here. So if we view these as logical relations, then we
    get... something very similar to DeMorgan, anyway.

[^9]: The term "proof engineer" is used according to what I understand
    the guys at Data61 understand of it. They were hiring proof
    engineers last time I looked.

[^10]: This can be proven separately using the same techniques employed
    in the rest of the essay. Proving computational complexity
    represents in fact the first attempt at structural induction of most
    computer science students.

[^11]: Most programmers write a wrapper around that, but I've avoided
    doing this for the sake of a brevity... which is lacking anyway.

[^12]: The concept of fold, or catamorphism, from
    [category theory][category-theory] provides some insight into
    this. No, we're not going to introduce another concept here,
    although the curious proof engineer is encouraged to look it up.

[^13]: Quantification is yet another important aspect in formal
    logic. Say, when you have something like `f(x) = x`, then this is in
    fact analogous to saying "given an arbitrary `x`, then `f(x)` returns
    `x`". I've overlooked this in my initial list of assumptions, but in
    this particular case it makes a huge difference, kinda like the joke
    with uncle Jack off a horse.

[^14]: It took me about two hours, but I've been through this a while
    ago while playing with Benjamin Pierce's
    [Software Foundations][pierce-sf] and Coq.

[^15]: Where "to scale" is used here in the
    "[derived from prime mover][scale-abstraction]" sense, i.e.:

    > **mircea_popescu**: davout something (convenience, anything else)
    > is correct if it scales, which is to say is derived from the prime
    > mover. anything else - incorrect.  
    > **mircea_popescu**: sinful is also a proper attribute of
    > incorrectness, because it is literally a headless spawn of the
    > very devil.  
    > **davout**: not sure i really get what you mean by "it scales"  
    > **davout**: if you bundle lots of shit, it quickly becomes
    > unmanageable  
    > **davout**: because all abstractions and conveniences have a cost  
    > **mircea_popescu**: not so. i can go from everything i do in an
    > infinite string of correct whys to prime logic. broken shit can't
    > do that.  
    > **davout**: what's "prime mover" in this context?  
    > **mircea_popescu**: possibly your idea of "scales" is tainted by
    > the idiots, "to scale means to be used by a larger cattle
    > headcount". that has nothing to do. to scale means to go up the
    > abstraction tree. an apple is a correct apple if it scales, ie, if
    > the concept of apple follows from it.  
    > **mircea_popescu**: literally the aristotelian imperative. the
    > first thing to have moved.
    >
    > [...]
    >
    > **mircea_popescu**: all you need is a false implication somewhere,
    > davout ; ANYWHERE. once you have it then everything becomes
    > provable.

[^16]: Formal verification was a thing for hardware way before the huge
    software systems that we have today emerged. It makes a lot of sense
    to verify hardware, as hardware is relatively simple to specify --
    at least in theory, if you don't count dinosaurs such as Intel's x86
    -- and it absolutely has to work before it reaches the customer's
    shelf. This also holds true for *some* software, but even with a
    bare metal environment and a C compiler one can very easily run into
    unknown unknowns, which may cause the world to explode.

[^17]: See McCarthy, John. [LISP 1.5 programmer's manual][lisp]. MIT
    press, 1965. Particularly Chapter 1.6 (pp. 10--14) describing the
    basic evaluation mechanism, and Appendix B (pp. 70--72) describing
    `prog`, which can be used to implement iterative loops, particularly
    the `do` macro used by us here.

[^18]: I'm not venturing to guess what these terms mean today. In my
    particular variety of the English language it means "someone who
    knows reasonably well what they're doing with computers".

[heiser-verified]: http://archive.is/DxjdB
[linguistic-barrier-os]: /posts/y01/03a-the-linguistic-barrier-of-os-design.html
[numbers]: /posts/y00/01d-on-numbers-structure-and-induction.html
[category-theory]: /posts/y02/042-category-theory-software-engineering.html
[pierce-sf]: http://www.cis.upenn.edu/~bcpierce/sf/current/index.html
[scale-abstraction]: http://btcbase.org/log/2017-01-12#1601833
[lisp]: http://www.softwarepreservation.org/projects/LISP/book/LISP%201.5%20Programmers%20Manual.pdf
[software-engineering]: /posts/y03/04e-the-myth-of-software-engineering-iii.html
