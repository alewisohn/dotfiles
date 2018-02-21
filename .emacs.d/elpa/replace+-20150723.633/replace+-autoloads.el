;;; replace+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "replace+" "replace+.el" (22003 10934 0 0))
;;; Generated autoloads from replace+.el

(autoload 'toggle-replace-w-completion "replace+" "\
Toggle whether to use minibuffer completion for `query-replace'.
This toggles the value of option `replace-w-completion-flag'.
During completion, you can insert a SPC or TAB char by preceding it
with `\\[quoted-insert]'.

A non-negative prefix arg means set `replace-w-completion-flag' to t.
A negative prefix arg means set it to nil.

\(fn FORCE-P)" t nil)

(autoload 'toggle-search/replace-region-as-default "replace+" "\
Toggle whether to use the active region text as default.
This toggles the value of option
`search/replace-region-as-default-flag', which affects search and
replace commands.

\(fn MSGP)" t nil)

(autoload 'query-replace-w-options "replace+" "\
Replace some occurrences of OLD text with NEW text.
This is like `query-replace' or `query-replace-regexp'.  A prefix arg
determines what kind of matches to replace, as follows:

* None:                                literal string, forward
* Plain (`C-u'):                       word,           forward
* `-' (e.g. `C- -'):                   literal string, backward
* Non-negative numeric (e.g. `C- 2'):  regexp,         forward
* Negative numeric (e.g. `C- -2'):     regexp,         backward

See options `search/replace-region-as-default-flag',
`search/replace-2nd-sel-as-default-flag', and
`search/replace-default-fn' regarding default values of OLD and NEW.

Option `replace-w-completion-flag', if non-nil, provides for
minibuffer completion while you type OLD and NEW.  In that case, to
insert a SPC or TAB character, you will need to precede it by `\\[quoted-insert]'.

If option `isearchp-set-region-flag' is non-nil, then select the last
replacement.

\(fn OLD NEW &optional KIND START END MSGP)" t nil)

(defalias 'list-matching-lines 'occur)

(autoload 'occur-mode-goto-occurrence-other-window "replace+" "\
Go to the occurrence for the current line, in another window.
Highlight the visited line number in the occur buffer.
Highlight the occur regexp in the source buffer.

\(fn)" t nil)

(autoload 'occur-mode-display-occurrence "replace+" "\
Display in another window the occurrence for the current line.
Highlight the visited line number in the occur buffer.
Highlight the occur regexp in the source buffer.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; replace+-autoloads.el ends here
