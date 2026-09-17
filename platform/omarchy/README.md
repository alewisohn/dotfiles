# Omarchy profile

Files under `config/` are linked into `~/.config` while preserving their
relative paths. Files under `home/` ending in `.symlink` are linked directly
into the home directory with the suffix removed. Shell files under `shell/`
are loaded only when the `omarchy` profile is active.

Omarchy uses Bash as its login shell. `home/bashrc.symlink` first sources the
managed `default/bash/rc` from the current package location (with a fallback
for older `~/.local/share/omarchy` installations), preserving Omarchy's
environment and prompt setup. It then loads the portable aliases and
environment settings from this repository. The macOS Zsh configuration is not
linked on Omarchy.

Add only intentional overrides here. Avoid linking whole configuration
directories that Omarchy manages and may update itself.
