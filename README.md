# Setting up a new machine
There are two not-awful ways we could go about setting up a new machine:
- install some snapshot software that sets up all my machines from an identical snapshot
- maintain a long-ass setup script that I run to set up a new machine, that I poke over time to add and remove things from.

Many users opt for the first. The issues with the first are mostly non-reproducibility, and the absence of a useful note to hand to future versions of myself (and others) when I wonder how the hell things got this way.

The second can be done well, with some design. Goal:
- **All the binaries I want should "just exist" when I setup a new machine, or switch between machines.**

This means that when I run `rustup update` or `apt upgrade` on one machine, I want my binaries to be updated everywhere.

## System
System breaks down into four parts:
- setup (here): Do it once. Set up everything. Allow that the setup script might break. 
- update script: Managed by `dotbot`, the update script should keep my systems in sync, and be run every 10 minutes by cron.
- binary storage: Package managers install binaries to different locations. Just keep a `.bin/{cargo,local,share,...}` location. Symlink to it from the other places binaries get installed.
- cron: manage the cron daemon to keep it all automatically glued together.

## Setup
Start: 
```sh
git clone git@github.com:thor314/.setup.git 
# get binaries, configuration files, and crons.
source .setup/install.sh
start-setup # install fish, clone .files, cron, bins, switch shell.
# WAIT AWHILE. 
fish .setup/finish.fish
```

