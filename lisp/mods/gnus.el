;;
;; Gnus newsgroup setup
;;
(require 'nnir)

(setq gnus-select-method '(nnnil))

(setq gnus-secondary-select-methods '((nntp "news.gwene.org")))

(setq
 user-full-name "Henry Wang"
 user-mail-address "henry118@gmail.com"
 )

(setq smtpmail-auth-credentials "~/.authinfo")

(setq
 gnus-posting-styles
 '((".*"
    (signature "Regards,\nHenry Wang\n\nSent from Emacs Gnus.")
    )
   ))

(add-to-list
 'gnus-secondary-select-methods
 '(nnimap
   "gmail"
   (nnimap-address "imap.gmail.com")
   (nnimap-server-port 993)
   (nnimap-stream ssl)
   (nnir-search-engine imap)
   (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
   (nnmail-expiry-wait 90)
   )
 )

(setq
 message-send-mail-function 'smtpmail-send-it
 smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
 smtpmail-auth-credentials '(("smtp.gmail.com" 587 "henry118@gmail.com" nil))
 smtpmail-default-smtp-server "smtp.gmail.com"
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 587
 )

(setq-default
 gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
 gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
 gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
 gnus-sum-thread-tree-false-root ""
 gnus-sum-thread-tree-indent ""
 gnus-sum-thread-tree-leaf-with-other "-> "
 gnus-sum-thread-tree-root ""
 gnus-sum-thread-tree-single-leaf "|_ "
 gnus-sum-thread-tree-vertical "|")

(setq
 gnus-thread-sort-functions
 '(
   (not gnus-thread-sort-by-date)
   (not gnus-thread-sort-by-number)
   ))

(setq gnus-use-correct-string-widths nil)

(defun hwang:gnus-group-list-subscribd-groups()
  "List all subscribed groups with or without un-read messages."
  (interactive)
  (gnus-group-list-all-groups 5)
)

(defun hwang:gnus-group-mode-hook()
  (local-set-key (kbd "o") 'hwang:gnus-group-list-subscribd-groups)
)

(add-hook 'gnus-group-mode-hook 'hwang:gnus-group-mode-hook)

(provide 'mods/gnus)
