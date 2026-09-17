# Dotfiles

My personal development environment for two systems: a macOS work laptop and
an Omarchy personal computer. The repository keeps shared preferences in one
place while isolating operating-system-specific packages, shell configuration,
commands, and application settings.

This is an opinionated personal setup, not a general-purpose dotfiles
distribution. It assumes the tools, directory layout, and workflows I use.

## Supported systems

| Profile | System | Shell | Package manager |
| --- | --- | --- | --- |
| `macos` | macOS | Zsh | Homebrew |
| `omarchy` | Omarchy/Arch Linux | Bash | pacman |

The profile is detected from `uname`. Set `DOTFILES_PROFILE` in `~/.localrc`
to override it explicitly.

## Repository layout

```text
bin/                Shared commands available on PATH
config/             Shared files linked beneath ~/.config
functions/          Shared Zsh functions
git/                Shared Git configuration and aliases
shell/              Portable shell fragments
platform/macos/     All macOS-only configuration and tooling
platform/omarchy/   All Omarchy-only configuration and tooling
script/             Bootstrap and package-install entry points
```

The macOS profile contains its Brewfile, Zsh entry point, Homebrew setup,
system defaults, platform commands, and AeroSpace, Borders, and Karabiner
configuration. See `platform/macos/README.md` for its structure.

The Omarchy profile contains its Bash entry point and pacman package list. Its
`.bashrc` preserves Omarchy's managed Bash layer before loading my overrides.
See `platform/omarchy/README.md` for details.

## Installation

```sh
git clone git@github.com:alewisohn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

Bootstrap detects the active profile, creates the appropriate symlinks, and
installs that platform's dependencies. Existing files are never silently
replaced: the script asks whether to skip, overwrite, or back them up.

To create or refresh symlinks without installing packages:

```sh
script/bootstrap --skip-packages
```

Run the maintenance command periodically to update the repository and install
or upgrade dependencies for the active profile:

```sh
dot
```

On macOS, `dot` also applies system defaults and updates Homebrew. On Omarchy,
it installs missing packages listed in `platform/omarchy/packages.txt` without
replacing Omarchy's base configuration.

## How files are loaded

- Shared files under `config/` retain their relative paths beneath
  `~/.config`.
- Files under `platform/<profile>/config/` are linked the same way, but only
  for the active profile.
- Files ending in `.symlink` under a topic or `platform/<profile>/home/` are
  linked into the home directory with the suffix removed.
- macOS loads shared Zsh files plus `platform/macos/shell/**/*.zsh`. Files named
  `path.zsh` load first and `completion.zsh` files load last.
- Omarchy uses `platform/omarchy/home/bashrc.symlink`, which sources Omarchy's
  managed `default/bash/rc` and then a deliberate set of Bash-compatible shared
  aliases and functions.
- Shared commands should be portable. When behavior differs by platform, they
  dispatch through helpers such as `bin/clipboard-copy`.

## Machine-local configuration

Secrets, employer-specific values, and machine-only overrides belong in
`~/.localrc`, which is sourced by both shell profiles and is not tracked.

Git identity and credentials live in the generated, untracked
`git/gitconfig.local.symlink`. Platform-specific Git behavior is kept in each
profile's `home/gitconfig.platform.symlink`.

## Adding configuration

- Put configuration shared by both systems at the repository root or under
  `config/`.
- Put macOS-only files under `platform/macos/`.
- Put Omarchy-only files under `platform/omarchy/`.
- Avoid symlinking entire directories managed by Omarchy; add only intentional
  overrides so Omarchy upgrades can continue to manage their defaults.

## Origins

This repository originally grew from Zach Holman's dotfiles, but it has since
been substantially reorganized around my own macOS and Omarchy environments.
The topic-oriented convention remains an influence; the configuration and
platform architecture here are personalized for my systems.
