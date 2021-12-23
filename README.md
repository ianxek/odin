# Odin language microbenchmarks

Before committing myself to writing scientific computing code in
[Odin](https://odin-lang.org/) I decided
to microbenchmark it. As I often did previously with other languages, I begin with some of
[Daniel Lemire's](https://lemire.me/blog/) microbenchmarks which he describes in some of his blog entries.

As for the pertinence of microbenchmarks, Daniel Lemire [provides ample
justifications](https://lemire.me/blog/2018/01/16/microbenchmarking-calls-for-idealized-conditions/), and I concur
with him.

I thank the Odin community for the patient expounding of (not so) basic points of the language, and
of course *the code I write is in no way a product of the community's wisdom nor do I claim it is optimal
Odin.*

## Personal bias

I decided to properly learn a C/C++ improved language because I enjoy the C coding experience and
its excellent performance, but at the same time, as an end-user, I long for a similar language
without the pain and that would allow more flow. I thus spent quite some time looking for a language
worth investing precious time in and ended up with Odin because :

* it feels like C, [vastly improves on it](https://odin-lang.org/docs/overview) and I can call
  those venerable language libraries from Odin apparently without much fuss ;
* it is pragmatic : nothing fancy, and not trying to reinvent the wheel, just taking into account slowly,
  painfully acquired programmers' experience (like C++-20 and later but without the ball and chain of older C++)
* it doesn't claim to be the one to rule them all ;
* it is used in production for a really impressive software that needs hardcore computations, and I
  need a language that can walk that walk ;
* its creator, Ginger Bill, is quite persuasive, [design
  coherent](https://www.youtube.com/watch?v=DNpcxkHnnL4&t=1588s), unquestionably competent
  and has a vision (he knows what he wants and doesn't, he *makes choices*) ;
* the [community](https://discord.com/invite/odinlang) is very active and welcoming.

And yes, I know also about other recently evolved species out there, functional or imperative :
Unison, Roc, V, Zig, Pure, Julia, Q, Pony, Rust, etc. I like and use Julia quite a lot for example, and
have already invested quite some time in Pony and Rust, but Odin fits a specific set of requirements I have,
as I tried to outline above, and at some point you need to decide what to invest serious precious
time in. So this is phase two for Odin, microbenchmarks.

## Goals

With those microbenchmarks, I can progressively test if Odin has a chance to fit my requirements and
at the same time learn the language properly for my needs ; I also intend to use that as an
opportunity to work through [Bakhvalov's book on performance
tuning](https://www.amazon.com/Performance-Analysis-Tuning-Modern-CPUs/dp/B08R6MTM7K). As long as I
get the performance I want (C++ competitive) I will continue until satisfied and then proceed to
write the code for my non-toy projects while at the same time contributing to Rosetta, Euler,
Lovelace and Shootout.

## bench001 : Running sum

Here I make a dynamic array, fill it with 32 bit integers (cpp int) and compute the running sum
so if array is `[1,1,4]` then the running sum is `[1,1+1,1+1+4]`. That sum is computed in-place ;
what gets timed (in millions of i32 per second) is the latter computation, not the filling up of the array.

__Results__ : For my initial try, with full compiler optimization, Odin (version
dev-2021-12:0548db42) is 5 times slower as CPP compiled with clang12 and -O3, which means it is
about as fast as CPP compiled with no optimization.  _N.B. That is before feedback from the
community_ : I will post an additional modified code after the probable suggested modifications.
