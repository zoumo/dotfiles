# Amo's dotfiles

## dotfiles

Your dotfiles are how you personalize your system. These are mine.

Holman was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. Holman realized him could split a lot of things
up into the main areas him used (Ruby, git, system libraries, and so on), so I
structured the project accordingly.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read Holman post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## First things first

Install [XCode command line tools](https://developer.apple.com/devcenter/mac/index.action). You will always need it anyway.

## Install Homebrew

[Homebrew](http://mxcl.github.com/homebrew/) is some kind of ports for Mac. As a developer, you should install it:

```sh
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
```

## Install zsh

[ZSH](http://www.zsh.org/) is a pretty powerful shell for *nix systems. As a developer, it just changed my life. I don't even know how I lived before using it. No, really, install it NOW:

```sh
brew install zsh
chsh -s /bin/zsh
```

## Install dotfiles

Run this:

```sh
git clone https://github.com/amowu/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## What's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/amowu/dotfiles/fork), remove what you don't
use, and build on what you do use.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Bugs

Holman want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## Thanks

I forked [Zach Holman](http://github.com/holman)' excellent
[dotfiles](http://github.com/holman/dotfiles).
