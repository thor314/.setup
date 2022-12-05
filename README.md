# Setting up a new machine
There are two not-awful ways we could go about setting up a new machine:
- install some snapshot software that sets up all my machines from an identical snapshot
- maintain a long-ass setup script that I run to set up a new machine, that I poke over time to add and remove things from.

Many users opt for the first. The issues with the first are mostly non-reproducibility, and the absence of a useful note to hand to future versions of myself (and others) when I wonder how the hell things got this way.

So we're building a script, with the following goal:
- **All the binaries I want should "just exist" when I setup a new machine, or switch between machines.**

This means that when I run `rustup update` or `apt upgrade` on one machine, I want my binaries to be updated everywhere.

## System
System breaks down into several parts:
- setup script: Do it once. Set up everything. Allow that the setup script might break.
- package-managers - we want them installed on setup and never poked again
- binaries - we want them synced across machines