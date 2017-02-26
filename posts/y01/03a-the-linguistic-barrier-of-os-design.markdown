---
postid: 03a
title: The linguistic barrier of operating system design
excerpt: A proposal to redesign the OS architecture from first principles.
date: July 11, 2015
author: Lucian Mogoșanu
tags: cogitatio, tech
---

General-purpose operating systems have gone through an interesting evolution in
the last five decades. From Unix, which has pretty much set the standard for OS
design, to Windows, Mac OS, Android, iOS, etc., this landscape has become more
and more varied in time in order to accommodate the need for computing machines
ranging from personal computers to mobile devices and servers. However, as
varied as they are, all operating systems have one thing in common: their
kernel, which itself has evolved throughout the decades.

The kernel, as the name suggests, is an operating system's central component.
From an engineering point of view, it is central in that it has full access to
the underlying hardware; moreover, its proper functioning is essential:
ideally, it must not have points of failure, nor must it impose security issues
on the system. Thus the idea of microkernels was born[^1]:

> A concept is tolerated inside the microkernel only if moving it outside the
> kernel, i.e., permitting competing implementations, would prevent the
> implementation of the system’s required functionality.

Examples of microkernels include Minix, QNX, L4 and Mach. The opposite concept
is that of monolithic kernels, which in addition implement at least some
services, e.g. device drivers, as kernel primitives. Examples of monolithic
kernels include FreeBSD, XNU, Linux and Windows NT.

The idea of monolithic kernels is clearly a paradox, as it contradicts our
earlier definition. This has led certain engineers to redefine the kernel as
the software component which runs in the processor's privileged mode -- e.g.
x86's "Ring 0" domain. However, while this definition is useful for all its
practical purposes, it does not hold any conceptual weight, and furthermore it
causes certain issues which become inherent in the operating system's overall
design.

I will reserve the rest of this post to present some of the existing OS kernel
designs from a historical perspective, from which some of the current kernel
design issues will stem. I will thus argue that OS design is facing what I call
a linguistic barrier, that is, an impossibility to describe the kernel's
functionality in order to meet current needs, and thus outgrow implementations
in older, unsafe programming languages such as C. Finally, I will propose a
general approach to this issue and draw a conclusion upon it.

## A brief history of OS kernels

The first successful attempt at creating an operating system, and thus an
operating system kernel, was Unix, namely Version 5, written in C for
PDP-11[^2]. Its current descendants are Unix BSD kernels (FreeBSD, NetBSD,
etc.) and to some degree Linux, which upholds most of the core principles of
Unix, despite being written from scratch. Unix kernels are monolithic in the
truest sense of the word: they implement core mechanims such as scheduling,
inter-process communication and memory management, along with device drivers
and other services such as random number generation entropy pools or file
systems. Their user space interface relies on the POSIX standard[^3], which is
portable in the sense that a standard C program written in 1990 for 80386 can
be compiled and run on nowadays' ARMv8 processors.

An alternative approach to kernel design started with the Mach microkernel,
which aimed at reducing the number of services running as privileged
applications. This has represented the majority of OS kernel research in the
last three decades, from Minix[^4] to Liedtke's L4 to seL4[^5]. While L4 solved
most of the performance issues specific to earlier microkernels, microkernels
remain largely unadopted, with the notable exception of QNX.

A yet different attempt at OS redesign, started in the '80s, was made by
Microsoft, IBM and Apple, with Windows NT, OS/2 and Mac OS/XNU respectively. In
particular, XNU started out by being built on top of Mach, but all three were
marketed as so-called "hybrid" kernels. While this may be true from a purely
architectural point of view[^6], their actual implementation is that of a
monolithic kernel; especially in the case of Windows -- e.g. Windows XP -- a
third-party application including privileged services running in the kernel
could easily crash the whole system, leading to the infamous Blue Screen of
Death.

In contrast with the previous attempts, Singularity[^7] proposes a whole new
approach to kernel design: the OS core is provided by a language run-time --
CLR in this particular case -- while all the other services and/or applications
run as so-called "software isolated processes", i.e. applications that conform
to, on one hand, compile-time checks, and on the other, run-time checks
performed by the virtual machine. The idea is interesting, although seemingly
useless, as it aims to replace hardware-enforced mechanisms with a possibly
buggy software stack; its novelty however relies on the fact that
performance-critical system-level services could be described and thus
implemented in a higher-level, safer language, as opposed to, say, C.

Finally, a new perspective on OS design is given by virtualization, to the
point that functionality is added in the hardware to make this practical.
Virtual machines aim to abstract an entire hardware computing system[^8] in
order to facilitate provisioning, for example by deploying an entire server
from a VM template, and also to isolate faults and security breaches.
Virtualization kernels are called hypervisors, and they are in many respects
similar to a classical OS kernel, as they provide similar basic mechanisms, the
main difference being that they are theoretically[^9] much closer in design to
a microkernel than to a monolithic kernel.

Although hypervisors may in fact add complexity, since they incur a layer of
abstraction in addition to the already complicated software stack employed on
top of monolithic kernels, they may also isolate it. Additionally, new
paradigms, such as that of Unikernels[^10], aim to remove complexity and
provide operating systems-as-appliances running on top of hypervisors. However,
hypervisors themselves are often deviating from the core principles of
microkernels and thus lack a certain degree of reliability[^11].

## Outstanding issues in OS kernel design

A fundamental problem with widely-deployed kernels such as Linux is that they
are not in fact kernels. In addition to the core mechanisms, they offer
functionality for file systems, virtualization, cryptography and many
others[^12], all of these so-called "subsystems" running at the same level of
privilege with the actual kernel, where by "level of privilege" we mean both
hardware and software privileges. Although malicious "kernel modules" are a
rare occurence, given that they can only be loaded by the most privileged user
in the system, faulty code is a common issue, tractable only palliatively
through the large developer base and cautious testing mechanisms of Linux.

In other words, chances of faulty code reaching the kernel's main branch are
relatively small from a statistical point of view, but the cost in man-hours
for ensuring this is significant[^13]. This comes only to support the notion
that Linux is in fact not a kernel in the purest conceptual sense.

On the other hand, microkernels such as seL4[^14] come with strong safety
guarantees, while remaining yet usable only as research tools. Given nowadays'
general context regarding security, we need such a deployable kernel not now,
but yesterday. Moreover, seL4 shows that verifiably safe kernels are feasible,
but not that they are practical, and furthermore it does not tell us anything
about verifiably safe operating systems or software systems in general.

One may argue that the microkernel, not unlike the monolithic kernel, provides
an extremist point of view: maybe some of the software in the system does
indeed need to run in the processor's most privileged mode, be it a special
hypervisor state or a classical "Ring 0". This would avoid the inherent
performance overhead required by hardware context switches, but it should not
come at the expense of reliability.

Thus I argue that the fundamental issue with operating system design is not
that software components requiring a certain level of privilege are run in Ring
0; that would be nonsense. The fundamental issue with operating system design
is that privileged operating system components -- often other than the
conceptual kernel, but sometimes even the kernel itself -- are written in an
unreliable manner. Projects such as Singularity and Mirage OS[^15] address this
issue, but I am not yet convinced that they do it holistically.

I also argue that the current state of affairs is as described due to a
so-called linguistic barrier that has been more or less acknowledged, but not
yet resolved in the field of OS research.

## The linguistic barrier of OS design

Most modern operating system architectures use a layered approach, sometimes
with the hypervisor representing the lowest software layer. Uncoincidentally,
that is why x86 protection modes are designed as so-called "rings": the initial
idea was that some of the OS components would be run in the most privileged
ring, while others would be employed in a less privileged ring. The
programmer's point of view can pe represented similarly, using the following
three layers, with Layer 0 being the most privileged:

* Layer 0, the hardware-specific language -- includes instructions that are
  typically never generated by compilers, e.g. return from interrupt, software
  interrupts, cache flushing mnemonics, etc.
* Layer 1, hardware-agnostic omnipotence -- no less privileged than Layer 0,
  only it includes components written in a high-level language such as C, to
  abstract the underlying instruction set architecture.
* Layer 2, hardware-enforced policies -- a separation layer including the
  system call API, virtual memory mappings, etc.
* Layer 3, the virtual machine -- virtual machines have their privileged
  confined by the lower layers; they are conceptually identical to processes,
  so they may or may not be provided with the same interface as the lower
  layers. Virtual machines may be written in any language or even multiple
  languages.

In a typical monolithic scenario, the kernel and a specific set of services,
e.g. device drivers, reside in Layer 0 and Layer 1, while other services and
applications reside in Layer 3. The fundamental strength of this scenario is
the possibility of direct access to I/O devices and strong coupling between OS
subsystems, while its fundamental weakness is the lack of fault tolerance for
components which require direct access to memory and OS data structures.

In a typical microkernel scenario, the kernel, and possibly a small set of
services, e.g. cache control mechanisms, reside in Layer 0 and Layer 1, while
the vast majority of services and applications reside in Layer 3. The
fundamental strength of this scenario represents strong hardware isolation
between services, applications and the kernel. Its fundamental weakness is the
requirement to set up a protocol for access to I/O devices and to allow
services to communicate among themselves and with applications; as far as
experience goes, this approach is expensive in terms of performance, without
providing portability. However, it has proven its usefuleness in the field of
virtualization, where an entire operating system is run in Layer 3.

In both scenarios there is a class of software components that do not benefit
from this structure: device drivers and low-level system services such as file
systems are unfit to be run either as tightly-coupled privileged components or
as user space applications. In the first case they are given the same
privileges as the trusted kernel; in the second case they must request
privileges from other entities and go through hardware context-switches to the
kernel each time they perform this action.

Thus I propose complementing this structure with a Layer 1.5, a software
managed, or rather language managed layer that is hardware-agnostic. Ideally,
such a layer is not to be used for performance-critical tasks that cannot be
handled by the language run-time. The language run-time itself resides in Layer
1 and it validates software-defined policies for services running in Layer 1.5
-- for example providing them with accesss to I/O or ensuring that only valid
byte code gets executed. Thus in a strictly orthodox design, the OS kernel
would consist of only the language run-time, while all other "kernel-level"
components would be developed in Layer 1.5.

This approach deserves a comparison with existing OS designs such as Windows NT
and XNU. Fundamentally it derives from them, the main difference is that
components such as loadable modules never cross their level of privilege and
data structure sharing is done only explicitly and through safe primitives,
e.g. for concurrency. It is also in many respects similar to the approaches
employed by Singularity and the various Unikernels, with the fundamental
difference that it is more general, thus being able to encompass one or both of
these approaches.

## Conclusion

I strongly believe that the approach presented in this post will break what I
termed a "linguistic barrier" with regard to the implementation of operating
system software components. Although I haven't presented any suitable languages
for this, there are a lot of possibilities, such as OCaml, Haskell, Rust[^16]
or SPARK[^17], some of which have already been used for operating system
development.

However interesting it might be, this approach poses questions and challenges.
For example, what components are run most efficiently in the language-managed
layer and which ones are best suited for user space? What is the right API
between the kernel and the language-managed applications? How can the
run-time/kernel be made small enough so that it can be thoroughly and scalably
verified?

[^1]: Liedtke, Jochen. On micro-kernel construction. Vol. 29. No. 5. ACM, 1995.

[^2]: Ritchie, O. M., and Ken Thompson. "The UNIX time-sharing system." Bell
System Technical Journal, The 57.6 (1978): 1905-1929.

[^3]: [POSIX.1-2008][posix]

[^4]: Herder, Jorrit N., et al. "MINIX 3: A highly reliable, self-repairing
operating system." ACM SIGOPS Operating Systems Review 40.3 (2006): 80-89.

[^5]: Klein, Gerwin, et al. "seL4: Formal verification of an OS kernel."
Proceedings of the ACM SIGOPS 22nd symposium on Operating systems principles.
ACM, 2009.

[^6]: Solomon, David A. "The Windows NT kernel architecture." Computer 31.10
(1998): 40-47.

[^7]: Hunt, Galen C., and James R. Larus. "Singularity: rethinking the software
stack." ACM SIGOPS Operating Systems Review 41.2 (2007): 37-49.

[^8]: Although one might argue that a hardware computing system is no different
from, say, the Java run-time, from a theoretical point of view. Each of them
can be used to achieve the very same goals, only with different costs in terms
of development effort, performance, security, flexibility, etc.

[^9]: Unfortunately this only applies to Type I hypervisors. VMware and KVM,
two canonical examples of Type II hypervisors, suffer from the same issues as
monolithic kernels, given that they always or most often integrate into
monolithic kernels.

[^10]: Madhavapeddy, Anil, and David J. Scott. "Unikernels: Rise of the Virtual
Library Operating System." Queue 11.11 (2013): 30.

[^11]: Wojtczuk, Rafal. "Adventures with a certain Xen vulnerability (in the
PVFB backend)." Message sent to bugtraq mailing list on October 15th (2008).

[^12]: A short look at the [Linux kernel tree][kernel] should confirm that.

[^13]: The author would like to note that this cost is most probably still
significantly smaller than the cost to formally verify a snapshot of the Linux
code base, not to mention maintaining those formal proofs. Albeit that is the
issue of Linux, not of formal verification.

[^14]: Elkaduwe, Dhammika, Gerwin Klein, and Kevin Elphinstone. "Verified
protection model of the seL4 microkernel." Verified Software: Theories, Tools,
Experiments. Springer Berlin Heidelberg, 2008. 99-114.

[^15]: [http://www.openmirage.org][mirage]

[^16]: [The Rust Programming Language][rust]

[^17]: [SPARK 2014][spark]

[posix]: http://pubs.opengroup.org/onlinepubs/9699919799/
[kernel]: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/
[mirage]: http://www.openmirage.org/
[rust]: http://www.rust-lang.org/
[spark]: http://www.spark-2014.org/about/
