;;; package --- Summary: Emacs init file
;;; Commentary:

;;; Code:
;; Set and load custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(package-initialize)

;; Setup PATH correctly
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Refresh packages
(when (not package-archive-contents)
  (package-refresh-contents))

;; Packages to install at startup
(defvar startup-packages
  '(projectile
    ack-and-a-half
    hlinum
    hardcore-mode))

;; Automatically install any missing packages
(dolist (p startup-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Ace Jump mode
(add-to-list 'load-path "~/.emacs.d/ace-jump-mode/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; APIB Mode
(add-to-list 'load-path "~/.emacs.d/apib-mode/")
(autoload 'apib-mode "apib-mode"
  "Major mode for editing API Blueprint files" t)
(add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode))

;; Smart Mode Line
(sml/setup)

;; Load theme
(load-theme 'wombat t)

;; Install el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )
(setq create-lockfiles nil)

;; Default to scratch buffer
(setq initial-scratch-message nil
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Automatically add newlines at end of buffer
(setq next-line-add-newlines t)

;; Set the default directory
(setq default-directory "/Users/andylewisohn/Dropbox/Workspace")

;; Make tooltips appear in the echo area
(setq tooltip-use-echo-area t)

;; Setup hardcore mode
(setq too-hardcore-backspace t)
(setq too-hardcore-return t)
(require 'hardcore-mode)
(global-hardcore-mode 1)

;; Setup ido (Interactively Do Things)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-decorations     ; Make ido-mode display vertically
      (quote
       ("\n-> "           ; Opening bracket around prospect list
        ""                ; Closing bracket around prospect list
        "\n   "           ; separator between prospects
        "\n   ..."        ; appears at end of truncated list of prospects
        "["               ; opening bracket around common match string
        "]"               ; closing bracket around common match string
        " [No match]"     ; displayed when there is no match
        " [Matched]"      ; displayed if there is a single match
        " [Not readable]" ; current diretory is not readable
        " [Too big]"      ; directory too big
        " [Confirm]")))   ; confirm creation of new file or buffer

(add-hook 'ido-setup-hook    ; Navigate ido-mode vertically
          (lambda ()
            (define-key ido-completion-map [down] 'ido-next-match)
            (define-key ido-completion-map [up] 'ido-prev-match)
            (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
            (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)))

;; Setup hlinum mode
(require 'hlinum)
(hlinum-activate)
(setq linum-highlight-in-all-buffersp t)

;; Setup projectile mode
(projectile-global-mode 1)
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

;; Setup recentf mode
(require 'recentf)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
(recentf-mode t)
(setq recentf-max-saved-items 50)

;; Redefine how recentf finds files
(defun ido-recentf-open ()
  "Use `ido-completing-read` to \\[find-file] a recent file."
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; Reconfigure `find-ls-option` to collate matches first
(require 'find-dired)
(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

;; Setup fic-mode for all programming modes
(require 'fic-mode)
(add-hook 'prog-mode-hook 'fic-mode)

;; Setup bash completion
(require 'bash-completion)
(bash-completion-setup)

;; Pyenv setup
(require 'pyenv-mode)

(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))
    (when (member project (pyenv-mode-versions))
	  (pyenv-mode t)
      (pyenv-mode-set project))))

;; Integrate pyenv with projectile
(add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)

;; Start flycheck on init
(add-hook 'after-init-hook #'global-flycheck-mode)

;; use web-mode for .jsx files
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; Start jedi in python mode
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(eval-after-load 'jedi
  '(progn
     (define-key jedi-mode-map (kbd "<C-tab>") 'jedi:complete)))

;; Configure ipython
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out \\[[0-9+\\]: "
 python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code "';'.joins(module_completion('''%s'''))\n"
 python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; Set some keys
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-v") 'eval-buffer)
(global-set-key (kbd "C-c C-j") 'idomenu)
(global-set-key "\M-'" 'insert-quotations)
(global-set-key "\M-\"" 'insert-quotes)
(global-set-key (kbd "C-'") 'insert-backquote)

(defun insert-quotations (&optional arg)
  "Enclose following ARG sexps in quotation marks.
Leave point after open-paren."
  (interactive "*P")
  (insert-pair arg ?\' ?\'))

(defun insert-quotes (&optional arg)
  "Enclose following ARG sexps in quotes.
Leave point after open-quote."
  (interactive "*P")
  (insert-pair arg ?\" ?\"))

(defun insert-backquote (&optional arg)
  "Enclose following ARG sexps in quotations with backquote.
Leave point after open-quotation."
  (interactive "*P")
  (insert-pair arg ?\` ?\'))

(defcustom comment-auto-fill-only-comments nil
  "Non-nil means to only auto-fill inside comments.
This has no effect in modes that do not define a comment syntax."
  :type 'boolean
  :group 'comment)

;; Turn on auto file but restrict it to comments
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq comment-auto-fill-only-comments t)
(setq-default auto-fill-function 'do-auto-fill)

;; Accept y or n in place of yes or no
(defalias 'yes-or-no-p 'y-or-n-p)

;; Automatically revert buffers
(setq revert-without-query t)

;; Maximize frame on start
(toggle-frame-maximized)

(put 'erase-buffer 'disabled nil)

;; Flycheck Python integration
;; (defun flycheck-python-set-executables ()
;;   (let ((exec-path (python-shell-calculate-exec-path)))
;;     (setq flycheck-python-pylint-executable (executable-find "pylint")
;;           flycheck-python-flake8-executable (executable-find "flake8")))
;;   ;; Force Flycheck mode on
;;   (flycheck-mode))

;; (defun flycheck-python-setup ()
;;   (add-hook 'hack-local-variables-hook #'flycheck-python-set-executables
;;             nil 'local))

;; (add-hook 'python-mode-hook #'flycheck-python-setup)

(flycheck-add-mode 'javascript-eslint 'web-mode)
(flycheck-add-mode 'javascript-eslint 'json-mode)

(add-hook 'elixir-mode-hook 'flycheck-mode)

(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; for better jsx syntax-highlighting in web-mode
;; - courtesy of Patrick @halbtuerke
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; Setup Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(provide 'init)
;;; init.el ends here
(put 'downcase-region 'disabled nil)
