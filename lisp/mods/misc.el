;;
;; Misc tweaks
;;

(custom-set-variables
 ;'(browse-url-browser-function (quote w3m-browse-url))
 '(c-basic-offset 4)
 '(c-offsets-alist
   (quote
    ((substatement-open . 0)
     (case-label . +)
     (innamespace . 4)
     (arglist-intro . +)
     (arglist-close . 0))))
 ;'(cua-mode t nil (cua-base))
 '(display-time-day-and-date t)
 '(display-time-mode t)
 '(gdb-find-source-frame t)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gdb-speedbar-auto-raise t)
 '(gdb-use-separate-io-buffer t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(make-backup-files nil)
 '(show-paren-mode t)
 '(which-function-mode t)
 '(pastebin-api-dev-key (getenv "PASTEBIN_KEY"))
 )

(defun hwang:before-save-hook()
  (if (not (string-equal mode-name "Markdown"))
      (delete-trailing-whitespace))
)

(add-hook 'before-save-hook 'hwang:before-save-hook)

;; Gobal Key Bindings
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "C-'") 'magit-status)
(global-set-key (kbd "C-x o") 'switch-window)

(when (is-mac)
  (global-set-key (kbd "<home>") 'beginning-of-line)
  (global-set-key (kbd "<end>") 'end-of-line)
)

;; Quick window switch
;;(windmove-default-keybindings 'meta)

;; Language environmenet to UTF-8
(set-language-environment 'UTF-8)

;; Turn on mouse support when running in terminal
(when (not (display-graphic-p))
  (xterm-mouse-mode t)
  (global-set-key (kbd "<mouse-4>") '(lambda () (interactive) (scroll-down 2)))
  (global-set-key (kbd "<mouse-5>") '(lambda () (interactive) (scroll-up 2)))
  )

;; I don't use tool bar at all!
(tool-bar-mode 0)

;; Who use the bar to scroll?
(when (display-graphic-p)
  (scroll-bar-mode 0))

;; Keep quiet
;(setq visible-bell t)

;; TRAMP uses SSH
(setq tramp-default-method "ssh")

;; Turn on EPA by default
(epa-file-enable)
(setq epa-pinentry-mode 'loopback)

;; Projectile
(projectile-global-mode)
(setq projectile-project-search-path '("~/devel/"))
(setq projectile-enable-caching t)

;; Customize iSpell
(cond
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-local-dictionary-alist
        ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)
          )))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))

;; Customize minimap
;(minimap-mode)
(setq minimap-window-location 'right)
(setq minimap-width-fraction 0.01)

(provide 'mods/misc)
