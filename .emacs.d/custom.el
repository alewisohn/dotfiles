(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-insert-directory "~/.emacs.d/auto-insert-templates")
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "e24180589c0267df991cf54bf1a795c07d00b24169206106624bb844292807b9" default)))
 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "PYENV_ROOT")))
 '(fill-column 80)
 '(flycheck-checkers
   (quote
    (ada-gnat asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint d-dmd emacs-lisp emacs-lisp-checkdoc erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck groovy haml handlebars haskell-stack-ghc haskell-ghc haskell-hlint html-tidy jade javascript-eslint javascript-jscs javascript-jshint javascript-gjslint javascript-standard json-jsonlint less luacheck lua perl perl-perlcritic php php-phpmd php-phpcs puppet-parser puppet-lint python-flake8 python-pylint python-pycompile r-lintr racket rpm-rpmlint rst rst-sphinx ruby-rubocop ruby-rubylint ruby ruby-jruby rust sass scala scala-scalastyle scss-lint scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim sql-sqlint tex-chktex tex-lacheck texinfo verilog-verilator xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby)))
 '(flycheck-coffee-coffeelint-executable nil)
 '(flycheck-coffee-executable nil)
 '(flycheck-coffeelintrc "coffeelint.json")
 '(flycheck-elixir-credo-strict t)
 '(flycheck-eslintrc ".eslintrc")
 '(flycheck-javascript-jscs-executable nil)
 '(flycheck-javascript-jshint-executable nil)
 '(global-flycheck-mode t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(jedi:environment-root "/usr/local/var/pyenv/versions/default")
 '(js-indent-level 2)
 '(jsx-indent-level 2)
 '(magit-popup-use-prefix-argument (quote default))
 '(menu-bar-mode nil)
 '(mocha-command "./node_modules/.bin/mocha")
 '(mocha-options "--compilers=js:babel-register --recursive --reporter spec")
 '(mocha-which-node "node")
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("melpa-stable" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (graphql-mode typescript-mode toml-mode flycheck-credo elixir-mix elixir-mode yaml-mode websocket twilight-theme smex smart-mode-line simpleclip sass-mode replace+ rainbow-delimiters pymacs pylint pyflakes pyenv-mode projectile php+-mode paredit mocha markdown-mode magit jsx-mode json-mode jinja2-mode jedi-direx idomenu ido-ubiquitous idle-highlight-mode hlinum hardcore-mode handlebars-mode git-auto-commit-mode flycheck-flow fic-mode exec-path-from-shell ember-mode dockerfile-mode color-theme coffee-mode bash-completion anything anaconda-mode ack-and-a-half)))
 '(php-project-list
   (quote
    (("vmp" "~/Workspace/vice/vclamp/src/vmp" "" nil "" nil
      (("" . "")
       "" "" "" "" "" "" "" "")
      "" ""))))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" "node_modules")))
 '(python-environment-directory "/usr/local/var/pyenv/versions")
 '(python-shell-virtualenv-path "/usr/local/var/pyenv/versions/beatport-api-x")
 '(python-shell-virtualenv-root "/usr/local/var/pyenv/versions/beatport-api-x")
 '(reb-re-syntax (quote string))
 '(safe-local-variable-values (quote ((project-venv-name . "beatport-api-x"))))
 '(scroll-bar-mode nil)
 '(sh-indentation 2)
 '(sml/theme (quote dark))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(tramp-default-method "ssh")
 '(typescript-indent-level 2)
 '(visible-bell nil)
 '(web-mode-attr-indent-offset 2)
 '(web-mode-code-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fic-face ((t (:foreground "red" :weight bold))))
 '(font-lock-warning-face ((t (:foreground "red")))))
