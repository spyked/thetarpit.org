---
postid: '00d'
title: 'Composition operators: pipes'
excerpt: In which we describe Unix pipes using application and composition.
author: Lucian Mogoșanu
date: August 31, 2013
tags: math, tech
---

While this post will seem trivial to the average mathematician, it is
well-aimed at beginning functional programmers. To calm down the former, we
note that pipes aren't equivalent to (function) composition in the mathematical
sense.

First, let us see what's composition and what are pipes, and then we'll bring
them together. I'll illustrate the concepts using mathematical language and
Bash/Unix Shell where necessary, and Haskell most of the time.

<!--more-->

## Function composition

Assuming we know what a function is, we can define a binary algebraic operator
$\circ$ that operates on two arbitrary functions $f$ and $g$, yielding a third
function, $h \equiv f \circ g$. Now, there aren't many ways we can combine
functions, and it doesn't make sense for us to try doing this without knowing
the signatures of $f$, $g$ and $h$, so we'll assume the following:

$f : C \rightarrow D$

$g : A \rightarrow B$

where $A$, $B$, $C$ and $D$ are arbitrary sets. However, you have to agree with
me that we cannot combine functions defined in terms of *purely* arbitrary
sets. For example, addition is always between well-defined numbers: the
addition of a natural number and a real number will yield a real number only
due to the fact that $\mathbb{N} \subset \mathbb{R}$ and will not, generally
speaking, yield a natural number. There must therefore exist a link between
some of the sets $A$, $B$, $C$ and $D$. We'll choose $B = C$; we don't know why
we did this yet, there's no clear intuition at this point, but we do know that
the result $h$ must also be a function, say $h : E \rightarrow F$.

Let's suppose for a moment that we're really dumb and we read the signature of
a function as "$A$ goes to $B$" and "$C$ goes to $D$" and so on[^1]. When
combining two functions, it's pretty natural to apply our $B = C$ restriction,
i.e. it's pretty ok to say "$A$ goes to ($B = C$) goes to $D$". We have some
kind of pipeline there, but in fact our pipeline goes from $A$ to $D$, so it's
once again natural to think of our pipeline as a new function $h : A
\rightarrow D$. So there it is, the algebraic definition of function
composition; sort of.

But what's the meaning of "$A$ goes to $B$"? Well, it actually means "you give
$f$ an element of $A$ and it gives back an element of $B$". The pipeline would
thus go from $x \in A$ to $y \in B$ (or $y \in C$, whichever you prefer) and
then $g$ would take $y$ and turn it into a $z \in D$. Formally, we would say
that:

$z = h(x) = f(g(x))$[^2]

Haskell defines function composition as a (Haskell) function[^3]:

~~~~ {.haskell}
(.) :: (b -> c) -> (a -> b) -> a -> c
(.) f g = \ x -> f (g x)
~~~~

## Unix pipes

Pipes are a lot simpler to define if we rely on shell scripting background.
They are grounded in the Unix philosophy, from which a lot of simple utilities
(such as `ls`, `cat` or `grep`) sprung out. To do useful, automatized stuff
with them, administrators had to have a way to somehow combine them in a
meaningful manner. For example `tail` prints out only the last few lines of
some output, making it essentially a filter. We might, for some arbitrary
reason, only want to see the last few processes outputted by `ps aux`, in which
case we'll write `ps aux | tail`.

Indeed, we can do stuff that's a lot more complicated. For example, if we want
to print only the second column of the output, we'll squeeze the repeated
spaces with `tr -s ' '` and use the space separator to select the second
column, with `cut -d ' ' -f2`. The final one-liner looks as follows:

~~~~ {.bash}
$ ps aux | tail | tr -s ' ' | cut -d ' ' -f2
~~~~

We notice how the pipe (`|`) operator looks very similar to the function
composition described earlier. A programmer might thus wonder, "how can I use
the same model in Haskell?". Fortunately, the implementation is only a few
steps away.

As I mentioned before, pipes and function composition are not equivalent. The
first obvious difference is of syntactic nature: pipes run backwards, or rather
composed functions do. A rough approximation of how the above shell command
would look in Haskell is the following snippet:

~~~~ {.haskell}
cut ' ' 2 . tr ' ' . tail $ ps "aux"
~~~~

We observe that while pipes "flow" from left to right[^4], function composition
runs from right to left. Besides, in Haskell we had to use the application
(`$`) function on the first argument. That is because `(.)` composes functions,
while `($)` composes a function with an argument:

~~~~ {.haskell}
($) :: (a -> b) -> a -> b
~~~~

Thus we can define a "pipe" function in the following way:

~~~~ {.haskell}
-- act the same as ($), only left-associative
set infixl 0 -|
(-|) :: a -> (a -> b) -> b
(-|) = flip ($)
~~~~

and apply it on Haskell statements and functions:

~~~~ {.haskell}
*Main> 1 + 1 -| (+ 2) -| (* 2)
8
*Main> iterate (++ "a") "" -| take 5 -| tail -| filter (\ s -> length s < 4)
["a","aa","aaa"]
*Main> let tt = [(False, False), (False, True), (True, False), (True, True)]
*Main> tt -| map (uncurry (&&))
[False,False,False,True]
*Main> tt -| map (uncurry (||))
[False,True,True,True]
~~~~

## Taking it further

The keener eyes might have quickly observed that our `(-|)` function is in fact
very similar to the monadic bind (`>>=`) operator:

~~~~ {.haskell}
(>>=) :: Monad m => m a -> (a -> m b) -> m b
~~~~

In fact we can rewrite our previous examples using `(>>=)` and `return`. I will
include the first example, the rest will be left as an exercise to the reader:

~~~~ {.haskell}
*Main> return (1 + 1) >>= return . (+ 2) >>= return . (* 2)
8
~~~~

or, to illustrate that we run in the [identity][1] functor/monad:

~~~~ {.haskell}
*Main Data.Functor.Identity> :m +Data.Functor.Identity
*Main Data.Functor.Identity> let r = return :: a -> Identity a
*Main Data.Functor.Identity> runIdentity $ r (1 + 1) >>= r . (+ 2) >>= r . (* 2)
8
~~~~

Of course, it doesn't stop here. Pipes are implemented as a design pattern in
the [Pipes][2] Haskell library, where the `(>+>)` operator is used to compose
pipe objects (see [Control.Pipe][3] for more details). What's interesting is
that `(>+>)` is implemented as the Arrow `(>>>)`, or a flip of `(<+<)`/`(<<<)`,
which satisfies the [category laws][4]. Thus `(<+<)` and `(>+>)` can also be
considered composition operators in the mathematical (algebraic/categorial)
sense[^5].

A paradigm which focuses entirely on piping (and stacking) is [concatenative
programming][5]. As a programming style, it is reminiscent of old Reverse
Polish Notation calculators such as the ones produced by HP in the 1980s. As an
abstraction tool, it's more well-suited for some cases, while being less
well-suited for others. We won't go into the details here.

[^1]: Well, we actually kinda do that anyway.

[^2]: From what I remember, mathematicians prefer saying that
$f \circ g \equiv g(f(x))$. I've modified it for the sake of consistency, but
it's really the same thing.

[^3]: Things get a wee bit more complicated here. Haskell conventions are
actually well-grounded in mathematical formalisms. If you're interested in the
whys and hows and don't know where to start, look up natural transformations.
Function composition can be regarded as one.

[^4]: This looks more natural to people living in the western world.

[^5]: Unfortunately, I won't expand further on this subject right here, since
it belongs to Category Theory 101.

[1]: http://hackage.haskell.org/packages/archive/transformers/0.2.0.0/doc/html/Data-Functor-Identity.html
[2]: http://www.haskell.org/haskellwiki/Pipes
[3]: http://hackage.haskell.org/packages/archive/pipes/3.3.0/doc/html/Control-Pipe.html
[4]: http://en.wikipedia.org/wiki/Category_(mathematics)#Definition
[5]: http://evincarofautumn.blogspot.ro/2012/02/why-concatenative-programming-matters.html
