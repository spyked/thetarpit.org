---
postid: 025
title: Type algebra: the semantic ambiguity of nested lists
excerpt: A short incursion into limitations of algebraic types.
date: July 12, 2014
author: Lucian Mogoșanu
tags: math, tech
---

A while ago I had a short debate on the semantics and structure of the
so-called "nested lists". For example Scheme naturally allows us to define
structures such as:

~~~~ {.scheme}
'(2 (2 3) 4)
~~~~

Of course, this is an inherent quality of Lisp dialects, where code and data
blend and nested lists are required to express arbitrarily complex expressions.
Moreover, we should note that Lisp languages usually don't impose any type
strictness on lists (as lists are a particular case of pairs), allowing for
truly arbitrary code to be embedded inside a list, e.g.:

~~~~ {.scheme}
'(1 #t 'a "yadda")
~~~~

This, as you may know, is the worst nightmare of Haskellers, or, more
generally, of the ML camp. We like our structures to be defined in terms of a
single well-formed type, so if we had an arbitrary type $A$ and a type of lists
$L$ defined in terms of $A$, i.e. $L\;A$, it would be inherently impossible to
construct nested lists, due to it leading to the (impossible) equality $A =
L\;A$. Mathematics aside, if we were to define the following in Haskell:

~~~~ {.haskell}
> let f x = [x, [x]] in f 2
~~~~

we would get quite a nasty error, along the lines of:

~~~~
Occurs check: cannot construct the infinite type: t0 = [t0]
In the expression: x
In the expression: [x]
In the expression: [x, [x]]
~~~~

given that it's quite impossible to unify an arbitrary type `t0` with `[t0]`.

It is however possible, albeit unnatural, as we will see, to define nested
lists in Haskell. There exist at least two possible definitions, which I will
explore in the remaining paragraphs.

## Definining the type of nested lists

Before defining a nested-list type, which I take the liberty to name `NList`,
I'll start with observing that Haskell's built-in list type can be redefined
without all the sugary bells and whistles as follows:

~~~~ {.haskell}
data List a = Empty | Cons a (List a)
~~~~

Its so-called "interface" consists of the two constructors `Empty` and `Cons`
and of the functions `head` and `tail`, having the signatures:

~~~~ {.haskell}
head :: List a -> a
tail :: List a -> List a
~~~~

where `head` returns the first element of the ordered value-list pair, and
`tail` the second. We note that both are partial functions, i.e. applying them
on `Empty` will result in an error.

Having said all this, there is an easy way to construct a nested-list type
starting from the definition of `List`, and you might have already seen it: add
a second constructor, one which would allow inserting a list inside another.
The `NList` type would therefore look like something along the lines of:

~~~~ {.haskell}
data NList a = Empty | ConsElem a (NList a) | ConsList (NList a) (NList a)
~~~~

This doesn't look particularly bad, except we have one problem: we can no
longer define a single `head` function for this type. We would need to have two
`head`s, such as:

~~~~ {.haskell}
headNElem :: NList a -> a
headNList :: NList a -> NList a
~~~~

having the definitions:

~~~~ {.haskell}
headNElem (ConsElem x _) = x
~~~~

and

~~~~ {.haskell}
headNList (ConsList x _) = x
~~~~

Of course, we can also define a `tail` function:

~~~~ {.haskell}
tailNList :: NList a -> NList a
tailNList (ConsElem _ y) = y
tailNList (ConsList _ y) = y
~~~~

The problem with `headNElem` and `headNList` is that, not only they're partial
functions, but they're also unusable by themselves in practice. For the sake of
testing our implementation, let us define a `test_list` `[2, [2, 3], 4]`, or,
without sugar:

~~~~ {.haskell}
test_list :: NList Integer
test_list = ConsElem 2 $ ConsList (ConsElem 2 $ ConsElem 3 $ Empty)
	$ ConsElem 4 Empty
~~~~

If `test_list` were some arbitrary list, we'd have no way of knowing whether
the first element was built using `ConsElem` or `ConsList`, leading to the
following problem:

~~~~ {.haskell}
> headNList test_list 
*** Exception: drafts/NList1.hs:33:1-28:
	Non-exhaustive patterns in function headNList
~~~~

This is indeed problematic. One way around the issue would involve defining a
function `isList` that checks whether the head is a list or an element.
Another, very similar method would involve giving up `headNElem` and making
`headNList` have the return type `Either a (NList a)`. Both approaches would
result in code looking painfully similar to spaghetti, due to the necessity of
case handling. This gets especially nasty when we don't immediately care about
the nature of our elements, so we'd have to essentially duplicate code to do
one thing for two different cases. In other words, welcome to type hell. Or
limbo.

The third way consists in giving up `headNElem` and making `headNList` look
somewhat similar to `tailNList`, by providing the former with an additional
definition:

~~~~ {.haskell}
headNList (ConsElem x _) = ConsElem x Empty
~~~~

loosely translated as "take the head and insert it into an empty list",
ensuring that we always return a value of the type `NList a`.

To make our implementation more uniform, we can define some constructor
functions:

~~~~ {.haskell}
emptyNList :: NList a
emptyNList = Empty

consElem :: a -> NList a -> NList a
consElem = ConsElem

consList :: NList a -> NList a -> NList a
consList = ConsList
~~~~

and make our module export all the definitions useful for the outside world:

~~~~ {.haskell}
module NList
  ( NList
  , consElem
  , consList
  , emptyNList
  , headNList
  , tailNList
  ) where
~~~~

Note that this more convenient implementation is also incorrect. Calling
`headNList` on `[2, [2, 3], 4]` and returning a *list* defies the semantics of
lists: what we're doing is taking the element and wrapping it in a list; what
we *should* be doing is take the element and return it as it is, which we've
established we can't do in Haskell without cluttering the implementation. To
exemplify the ambiguity, we ponder what happens when we call `headNList` on
a singleton:

~~~~ {.haskell}
*NList> headNList (ConsElem 2 Empty) == ConsElem 2 Empty 
True
~~~~

meaning that we never know whether our `head` function returns a singleton or
an element, i.e. if the original list contained `2` or `[2]`. Either way, this
implementation of `NList` lacks consistency and would get our average
programmer into trouble quite quickly, no matter how we put it.

There is at least one more way to define nested-list types in Haskell. There
are probably more, but I will present only one more, and I will name it the
"alternate".

## An alternate definition

To provide this "alternate" definition, I propose the clean approach of reusing
the existing list type `[a]` to build our new type. Reiterating, our goal is to
let the Haskell programmer build lists with nested structure, as illustrated by
our earlier example, `[2, [2, 3], 4]`. Let's start by defining `NList` as
a type synonym:

~~~~ {.haskell}
type NList a = [a]
~~~~

This (quite obviously) doesn't work, because we want to be able to (possibly)
store lists inside other lists, intuitively leading us to the initial problem
of `NList a = [NList a]`. We can however express this type recurrence relation
in Haskell in a plain manner, using `data`:

~~~~ {.haskell}
data NList a = List [NList a]
~~~~

Notice that this is a legitimate Haskell type. It isn't however very useful
to us, since it only allows us to construct arbitrarily nested *empty* lists,
such as:

~~~~ {.haskell}
List [List [], List [List []]]
~~~~

By taking another look at the example above, we notice that the `NList` type
describes the proper structure, without however giving us the proper tools to
populate the lists with elements. We'll solve this by "lifting" elements into
lists, turning the definition into:

~~~~ {.haskell}
data NList a = Elem a | List [NList a]
~~~~

Given this context, the example `test_list` will have the definition:

~~~~ {.haskell}
test_list :: NList Integer
test_list = List [Elem 2, List [Elem 2, Elem 3], Elem 4]
~~~~

The rest of the interface stays the same: we can still build `headNList` and
`tailNList` with the previously defined interface. Note the partialness, i.e.
the impossibility of defining the functions on values constructed using `Elem`:

~~~~ {.haskell}
headNList (List (x : _)) = x
tailNList (List (_ : xs)) = List xs
~~~~

This holds as well for `emptyNList`, `consElem` and `consList`, which now
become a sort of "pseudo-constructors", as we can't define them purely as the
two constructors provided above. We can however define the former *in terms of*
the latter:

~~~~ {.haskell}
emptyNList = List []
consElem x xs = consList (Elem x) xs
consList x (List xs) = List $ x : xs
~~~~

The implementation of `consElem` and `consList` looks as elegant as it can get,
although we no longer have some of the nonsensical cases handled statically
(i.e. at type level); for example `consList (Elem 1) (Elem 2)` needs to be
kept undefined, either explicitly or implicitly.

To express the problem in semantical terms, we're rid of the ugly spaghetti
implementation and/or ambiguities, only we're now smashing our heads against
the dirty issue of having elements treated as lists! This might make sense in
the formal contexts of singletons or applicative functors, but here we're just
using this as a hack to obtain a practical advantage, which, in a way, beats
the whole purpose of correctness and clean design that Haskell programs should
stand for.

But before admitting defeat, let's make a short analysis of the problem at a
purely algebraic level.

## Some abstract nonsense

If you've got some insight of how Haskell works, you are probably aware of the
fact that Haskell types are built upon a mechanism called "algebraic data
types". Now, if you're a mathematician, you are very probably aware of the fact
that the various type-theoretical disciplines use only a few fundamental
operations to construct types, the most important being products, sums (also
called disjoint unions) and functions, with the possibility of reducing them
only to the former two if we view functions as a particular type of binary
relations (themselves expressed as products).

Getting back to programming for a bit, all (or most?) languages provide some
form of product and sum types: C has structs and unions respectively, and C++
also introduces classes and objects, which are in fact a whole different story.
Java doesn't have a union type, but the canonical `Either` type can be build on
top of classes; this is also true for Python, maybe due to the fact that
disjoint unions can cause real trouble in dynamically-typed languages. Finally,
Haskell user types are constructed exclusively based on products (e.g. `data
Pair a b = MkPair a b`) and sums (e.g. `data T = T1 | T2`). Mathematical
notation uses $\times$ to denote products and $+$ to denote sums.

Moreover, instead of using the set-theoretical $x \in A$, we would use $x : A$
for types, and we would define higher-order types by separating the type from
its parameter using a space character, e.g. $F\;X$. Also, the empty set would
by replaced by a so-called "unit" type, i.e. the type with a single value,
denoted as $\mathbb{1}$.

Using this language, we can define the type of lists as:

$L\;A = \mathbb{1} + A \times L\;A$

(Note that we assume that the precedences of the binary operators $\times$ and
$+$ are the same as those of arithmetic products and sums respectively.)

Looking back at `List`, we notice that the two definitions are isomorphic. We
can thus define the two `NList` types in the same way, I will call them
$\text{NL}_1$ and $\text{NL}_2$:

$\text{NL}_1\;A = \mathbb{1} + A \times \text{NL}_1\;A + \text{NL}_1\;A \times \text{NL}_1\;A$.

$\text{NL}_2\;A = A + L\;(\text{NL}_2\;A)$

Now, the first thing that pops to my mind by looking at the definitions of
$\text{NL}_1$ and $\text{NL}_2$ is that they look different; but can we *prove*
that the two types are equivalent? Assuming that $\times$ and $+$ are
distributive, could we juggle the two expressions in some way so that one leads
to the other? I'm not sure that we can. The best I can think of is doing some
factoring in $\text{NL}_1$'s equation, getting to:

$\text{NL}_1\;A = \mathbb{1} + (A + \text{NL}_1\;A) \times \text{NL}_1\;A$

The part $A + \text{NL}_1\;A$ seems to suggest that we can "select" between
values and lists, but other than that it doesn't seem that we can obtain the
second type from the first; nor do I venture to try and obtain the first from
the second, since $\text{NL}_2$'s definition depends on $L$. I will leave this
for the reader to explore further, I'm really curious if one can prove, or even
better, disprove the equivalence between the two.

## Conclusion

I've attached the Haskell source code for the two definitions as [NList1.hs][1]
and [NList2.hs][2] respectively. Feel free to browse through them, modify them
and get your own insight on the matter.

Ultimately, I believe that "nested lists" are an ill-posed problem. Ok, we have
at least two ways to define them, but what are they useful for? If we want to
model nested data, then maybe we're better off defining multi-way trees and
using them as such. If, on the other hand, we want to model arbitrary
expressions like Scheme does, then we'd better use the semantics of a "type of
expressions", along with the algorithms appropriate for this application.

Jonathan Tang's [Write Yourself a Scheme in 48 Hours][3] defines Lisp values in
a way looking strikingly similar to our second `NList` definition. This makes a
lot more sense, since an `Atom` (the equivalent of our `Elem`) may be a Lisp
value, although it's not necessarily a nested list. While this narrows down the
scope to the parsing and evaluation of Scheme expressions, it also looks much
clearer and cleaner, and it's unquestionably the manner in which programming
must be done in Haskell, or in any other strongly-typed functional language for
that matter.

[1]: /uploads/2014/07/NList1.hs
[2]: /uploads/2014/07/NList2.hs
[3]: http://jonathan.tang.name/files/scheme_in_48/tutorial/parser.html#primitives 
