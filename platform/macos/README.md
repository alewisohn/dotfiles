# macOS profile

Everything specific to macOS lives in this directory:

- `Brewfile` contains Homebrew formulae and casks.
- `bin/` contains macOS-only commands added to `PATH` by `shell/path.zsh`.
- `config/` is linked beneath `~/.config`.
- `functions/` contains macOS-only Zsh completions and functions.
- `home/` contains files linked directly into the home directory.
- `homebrew/` installs Homebrew when it is missing.
- `shell/` contains Zsh files loaded only by the `macos` profile.
- `system/` contains macOS defaults and hostname setup.

Shared commands and configuration remain at the repository root. Shared code
must either be portable or dispatch through a platform-aware helper such as
`bin/clipboard-copy`.
