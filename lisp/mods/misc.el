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
     (innamespace . 0)
     (arglist-intro . +)
     (arglist-close . 0))))
 '(cua-mode t nil (cua-base))
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
(windmove-default-keybindings 'meta)

;; Language environmenet to UTF-8
(set-language-environment 'UTF-8)

;; Turn on mouse support when running in terminal
(when (not (display-graphic-p))
  (xterm-mouse-mode t))

;; I don't use tool bar at all!
(tool-bar-mode 0)

;; Who use the bar to scroll?
(scroll-bar-mode 0)

;; Keep quiet
;(setq visible-bell t)

;; TRAMP uses SSH
(setq tramp-default-method "ssh")

;; Turn on EPA by default
;(epa-file-enable)

(provide 'mods/misc)
